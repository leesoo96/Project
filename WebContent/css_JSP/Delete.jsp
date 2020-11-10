<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시글 삭제</title>
<style>
@font-face {
    font-family: 'NEXON Lv2 Gothic';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@2.1/NEXON Lv2 Gothic.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

body {
  overflow-x: hidden;
  font-family: 'NEXON Lv2 Gothic';
}
table, tr, td {
  margin: 0;
  padding: 0;
}

#deleteTable {
  margin: 10% auto;
  padding: 5%;
}

#deleteTable tr:nth-child(1){
  font-weight: bold;
  font-style: italic;
  font-size: 25px;
}
#deleteTable tr:nth-child(1) td{
  border-bottom: 3px solid #444645;
  padding-bottom: 3%;
}

#deleteTable tr:nth-child(2) td{
  padding: 3% 0 3% 0;
}
#deleteTable tr:nth-child(2) input{
  font-size: 20px;
  border: 3px solid #444645;
}

#deleteTable tr:last-child td{
  text-align: right;
}
#deleteTable tr:last-child input {
  margin-left: 0px;
  padding-right: 0;
  background: #fff;
  border: 0;
  font-size: 16px;
  font-weight: bold;
}
#deleteTable tr:last-child input:hover {
  color: #ff9314;
}

</style>
</head>
<body>

</body>
</html>