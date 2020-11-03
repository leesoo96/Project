/**
 * Copyright(c) 2001 iSavvix Corporation (http://www.isavvix.com/)
 *
 *                        All rights reserved
 *
 * Permission to use, copy, modify and distribute this material for
 * any purpose and without fee is hereby granted, provided that the
 * above copyright notice and this permission notice appear in all
 * copies, and that the name of iSavvix Corporation not be used in
 * advertising or publicity pertaining to this material without the
 * specific, prior written permission of an authorized representative of
 * iSavvix Corporation.
 *
 * ISAVVIX CORPORATION MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES,
 * EXPRESS OR IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT
 * NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 * FITNESS FOR ANY PARTICULAR PURPOSE, AND THE WARRANTY AGAINST
 * INFRINGEMENT OF PATENTS OR OTHER INTELLECTUAL PROPERTY RIGHTS.  THE
 * SOFTWARE IS PROVIDED "AS IS", AND IN NO EVENT SHALL ISAVVIX CORPORATION OR
 * ANY OF ITS AFFILIATES BE LIABLE FOR ANY DAMAGES, INCLUDING ANY
 * LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL DAMAGES RELATING
 * TO THE SOFTWARE.
 *
 */
package Board;

import java.sql.*;
import java.util.Properties;
import java.util.Vector;

/**
 * Manages a java.sql.Connection pool.
 *
 * @author  Anil Hemrajani
 */
public class DBConnectionMgr {
//	연결 객체를 리스트형으로 저장하는 변수(10칸 확보)
    private Vector connections = new Vector(10);
    private String _driver = "org.mariadb.jdbc.Driver",
    _url = "jdbc:mysql://127.0.0.1:3307/mydb?useUnicode=true&characterEncoding=EUC-KR",
    _user = "root",
    _password = "wls120239";
    
//  알림메시지를 콘솔에 표시할지를 묻는 변수
    private boolean _traceOn = false;
    
//  pool 객체가 만들어져있는지를 묻는 변수(pool 객체 초기화 -> 객체가 있음)
    private boolean initialized = false;
    
//  pool 에 저장될 연결 객체의 개수 저장
    private int _openConnections = 10;
    
//  pool 객체의 주소 저장 / 전달 참조변수
    private static DBConnectionMgr instance = null;

    public DBConnectionMgr() {}

    /** Use this method to set the maximum number of open connections before
     unused connections are closed.
     */

//  *getInstance() -> Pool을 생성하는 메소드. pool의 주소를 전달한다(싱글톤 패턴방식)*
    public static DBConnectionMgr getInstance() {
        if (instance == null) { // pool 객체가 없으면 
        	
//   synchronized -> 하나를 처리한 후에 그다음 처리하도록 흐름제어(동기화)   
            synchronized (DBConnectionMgr.class) {
                if (instance == null) {
//                	현재 클래스로 pool 객체를 만들고 instance 변수에 저장
                    instance = new DBConnectionMgr();
                }
            }
        }
//      pool 객체 주소 리턴
        return instance; 
    }

//  pool 내부 연결 객체 개수 설정
    public void setOpenConnectionCount(int count) {
        _openConnections = count;
    }

//  Trace 기능 허용 여부, 현재 연결 상황 관련 정보를 추적확인
    public void setEnableTrace(boolean enable) {
        _traceOn = enable;
    }

//  pool에 존재하는 연결 객체 리스트 리턴
//  Vector 클래스 형으로 반환한다
    /** Returns a Vector of java.sql.Connection objects */
    public Vector getConnectionList() {
        return connections;
    }

//  생성시킬 연결 객체의 개수를 설정(실제로 만드는 작업)
    /** Opens specified "count" of connections and adds them to the existing pool */
    public synchronized void setInitOpenConnections(int count) throws SQLException {
    	
//  Connection -> Sql패키지 안에 연결 객체 생성을 위한 클래스 자료형 
        Connection c = null;
        
//  ConnectionObject -> 현재 이 공간에서 사용하기위해서 만든 클래스 자료형      
        ConnectionObject co = null;
        
//   전달받은 count수만큼 for문 반복
        for (int i = 0; i < count; i++) {
//        	연결 객체를 만들고 해당 주소를 c 에 저장
            c = createConnection();
            
//          ConnectionObject 객체를 만들고 연결 객체의 주소와 현재 DB연결 여부를 표시하는 플래그를 전달
            co = new ConnectionObject(c, false);
            
//          벡터 리스트에 ConnectionObject의 정보를 추가
            connections.addElement(co);
            trace("ConnectionPoolManager: Adding new DB connection to pool (" + connections.size() + ")");
        }
    }

//  현재 연결된 연결 객체 수 반환
    /** Returns a count of open connections */
    public int getConnectionCount() {
        return connections.size();
    }

//  *getConnection() -> 현재 미사용중(false)인 연결객체의 주소를 반환*
    /** Returns an unused existing or new connection.  */
    public synchronized Connection getConnection() throws Exception {
        if (!initialized) { // pool 객체가 만들어져있지않다면
        	
//        	드라이브 메모리 공간에 적재,
            Class c = Class.forName(_driver); 
            
//          드라이브 매니저 객체에 생성한 드라이브 객체를 등록,
            DriverManager.registerDriver((Driver) c.newInstance()); 
            
//          초기화 여부 true로 설정  
            initialized = true;
           }
        
        Connection c = null;
        ConnectionObject co = null;
        
//      현재 객체의 연결 상태가 불량인지 검사할 용도의 변수
        boolean badConnection = false;

//      저장된 연결 객체의 수만큼 for문 반복
        for (int i = 0; i < connections.size(); i++) {
        	
//        	i번째 연결 객체의 주소를 co 에 저장
            co = (ConnectionObject) connections.get(i);

            // If connection is not in use, test to ensure it's still valid!
            if (!co.inUse) { // 현재 연결 객체가 미사용중이라면,   
                try {
                	
//                	연결 여부 확인(연결X : true, 연결 : false)
//                	is -> 물어보는것으로 생각하면 된다
                    badConnection = co.connection.isClosed();
                    if (!badConnection)
//   getWarnings() -> 연결 객체의 경고 수준(레벨)을 리턴, 경고가 없을 경우 null을 리턴한다
                        badConnection = (co.connection.getWarnings() != null);
                } catch (Exception e) {
//                	기타 예외가 발생할 경우 불량 연결 플래그 저장
                    badConnection = true;
                    e.printStackTrace();
                }
                
//              연결상태가 불량할 경우,
                // Connection is bad, remove from pool
                if (badConnection) {
//                	리스트에 저장된 해당 객체 제거
                    connections.removeElementAt(i);
                    trace("ConnectionPoolManager: Remove disconnected DB connection #" + i);
                    continue; // for문으로 복귀
                }
                
//              연결상태가 불량이 아닐 경우,
//              리스트에서 가져온 연결 객체의 주소를 c 에 저장
                c = co.connection;
                
//              현재 연결 객체의 상태를 사용중인 상태(true)로 설정
                co.inUse = true;
                trace("ConnectionPoolManager: Using existing DB connection #" + (i + 1));
                break; // 반복문 탈출
            }
        }

//      c 가 null이라면( c = co.connection; -> null : 실제 연결 객체 공간이 없다)
        if (c == null) {
        	
//        	연결 객체를 만들고 c에 주소 저장
            c = createConnection();

//          플래그를 포함한 연결 객체를 만들고 사용 중(true)인 플래그 전달
            co = new ConnectionObject(c, true);
            
//          연결 객체 리스트에 해당 연결 객체 주소를 추가
            connections.addElement(co);
            trace("ConnectionPoolManager: Creating new DB connection #" + connections.size());
        }
//      현재 연결 객체 주소를 리턴
        return c;
    }

//  freeConnection() -> 연결객체 자원 해제
    /** Marks a flag in the ConnectionObject to indicate this connection is no longer in use */
    public synchronized void freeConnection(Connection c) {
        if (c == null)
            return;

        ConnectionObject co = null;

        for (int i = 0; i < connections.size(); i++) {
            co = (ConnectionObject) connections.get(i);
            if (c == co.connection) {
                co.inUse = false;
                break;
            } 
        }

        for (int i = 0; i < connections.size(); i++) {
            co = (ConnectionObject) connections.get(i);
            if ((i + 1) > _openConnections && !co.inUse)
                removeConnection(co.connection);
        }
    }

    public void freeConnection(Connection c, PreparedStatement p, ResultSet r) {
        try {
            if (r != null) r.close();
            if (p != null) p.close();
            freeConnection(c);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void freeConnection(Connection c, Statement s, ResultSet r) {
        try {
            if (r != null) r.close();
            if (s != null) s.close();
            freeConnection(c);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void freeConnection(Connection c, PreparedStatement p) {
        try {
            if (p != null) p.close();
            freeConnection(c);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void freeConnection(Connection c, Statement s) {
        try {
            if (s != null) s.close();
            freeConnection(c);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /** Marks a flag in the ConnectionObject to indicate this connection is no longer in use */
    public synchronized void removeConnection(Connection c) {
        if (c == null)
            return;

        ConnectionObject co = null;
        for (int i = 0; i < connections.size(); i++) {
            co = (ConnectionObject) connections.get(i);
            if (c == co.connection) {
                try {
                    c.close();
                    connections.removeElementAt(i);
                    trace("Removed " + c.toString());
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
            }
        }
    }

    private Connection createConnection()
            throws SQLException {
        Connection con = null;
        
        try {
            if (_user == null)
                _user = "";
            if (_password == null)
                _password = "";

            Properties props = new Properties();
            props.put("user", _user);
            props.put("password", _password);

            con = DriverManager.getConnection(_url, props);
        } catch (Throwable t) {
            throw new SQLException(t.getMessage());
        }
        return con;
    }

    /** Closes all connections and clears out the connection pool */
    public void releaseFreeConnections() {
        trace("ConnectionPoolManager.releaseFreeConnections()");

        Connection c = null;
        ConnectionObject co = null;

        for (int i = 0; i < connections.size(); i++) {
            co = (ConnectionObject) connections.get(i);
            if (!co.inUse)
                removeConnection(co.connection);
        }
    }

    /** Closes all connections and clears out the connection pool */
    public void finalize() {
        trace("ConnectionPoolManager.finalize()");

        Connection c = null;
        ConnectionObject co = null;

        for (int i = 0; i < connections.size(); i++) {
            co = (ConnectionObject) connections.get(i);
            try {
                co.connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            co = null;
        }
        connections.removeAllElements();
    }

    private void trace(String s) {
        if (_traceOn)
            System.err.println(s);
    }
}

class ConnectionObject {
    public java.sql.Connection connection = null;
    public boolean inUse = false;

    public ConnectionObject(Connection c, boolean useFlag) {
        connection = c;
        inUse = useFlag;
    }
}