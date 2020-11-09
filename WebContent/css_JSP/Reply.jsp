<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>답변글</title>
<style>
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

body {
  overflow-x: hidden;
}
div, ul, li, p, textarea {
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
  font-size: 20px;
  font-weight: bold;
}

#read_Box{
  border-top: 2px solid black;
  width: 75%;
  margin: 0 auto;
  font-family: 'NEXON Lv2 Gothic';
}

#read_Box_Menu p{
  margin: 1% 0 1% 3%;
}
#read_Box_Menu input{
  border: 0;
  font-size: 16px;
  font-family: 'NEXON Lv2 Gothic';
  width: 60%;
}

#read_Box_Content{
  clear: both;
  border-top: 2px solid gray;
}
#read_Box_Content p {
  margin: 1% 0 1% 3%;
}

#read_Box_Content input {
  border: 0;
  font-size: 16px;
  width: 70%;
  font-family: 'NEXON Lv2 Gothic';
}
.readContent {
  border-bottom: 2px solid gray;
}
.readContent p {
  border: 2px solid gray;
  height: auto;
  width: 95%;
  font-size: 16px;
  padding: 1.3% 0 1.3% 1.3%;
}
.reply_Box p {
  margin: 1% 0 1% 3%;
}
.reply_Box textarea {
  margin: 1% 0 1% 3%;
  width: 95%;
  border: 3px solid gray;
  font-size: 16px;
  font-family: 'NEXON Lv2 Gothic';
}

#read_Box_Bottom ul {
  text-align: right;
  float: right;
}
#read_Box_Bottom input{
  font-family: 'NEXON Lv2 Gothic';
  font-weight: bold;
  font-size: 16px;
  margin-left: 3px;
  border: 0;
  color: #595855;
  background-color: #fff;
}
#read_Box_Bottom input:hover{
  font-size: 17px;
  text-decoration: underline;
}


</style>
</head>
<body>

</body>
</html>