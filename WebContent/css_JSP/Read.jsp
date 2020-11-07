<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시글 읽기</title>
<style type="text/css">
@font-face {
    font-family: 'MaruBuri-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10-21@1.0/MaruBuri-Regular.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
@font-face {
    font-family: 'NEXON Lv2 Gothic';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@2.1/NEXON Lv2 Gothic.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

body{
  overflow-x: hidden;
}
div, ul, li {
  margin: 0;
  padding: 0;
}
a {
  text-decoration: none;
}
ul li {
  list-style: none;
}
#read_Table_Head {
  width: 45%;
  height: 40px;
  border-top-left-radius: 10px;
  border-top-right-radius: 10px;
  margin: 5% 0 0 28%;
  border: 2px solid black;
  background: #FFD2D2;
  text-align: center;
}
#read_Table_Head td{
  text-align: center;
  font-family: 'MaruBuri-Regular';
  font-weight: bold;
  font-size: 20px;
}

#read_Box{
  border-top: 2px solid black;
  width: 75%;
  margin: 0 auto;
}
#read_Box_Menu ul{

}
#read_Box_Menu ul li{
  font-family: 'MaruBuri-Regular';
  float:left;
  width: 180px;
  margin: 0.5% 0.5% 0.5% 5%;
  font-size: 16px;
}

#read_Box_Content{
  clear: both;
  border-top: 2px solid gray;
}
#read_Box_Content ul{
  margin-bottom: 1.5%;

}
#read_Box_Content ul{
  padding: 1.5% 0 1.2% 5%;
  border-bottom: 2px solid gray;
}
#read_Box_Content ul li {
  font-size: 16px;
  font-family: 'NEXON Lv2 Gothic';
}
#read_Box_Content .readContent li{
  margin-top: -2%;
  border: 1px solid black;
  height: 300px;
}
#read_Box_Content .readFile li{
  margin-top: -1.8%;
}

#read_Box_Bottom ul {
  text-align: right;
  float: right;
}
#read_Box_Bottom ul li {
  font-family: 'NEXON Lv2 Gothic';
}
#read_Box_Bottom li a {
  display: block;
  width: 50px;
  height: 30px;
  float: left;
  color: #595855;
  font-weight: bold;
}
#read_Box_Bottom li a:hover{
  font-size: 17px;
  text-decoration: underline;
}

</style>
</head>
<body>

</body>
</html>