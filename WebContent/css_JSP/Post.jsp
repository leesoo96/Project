<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시물 작성</title>
<style type="text/css">
@font-face {
    font-family: 'MaruBuri-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10-21@1.0/MaruBuri-Regular.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

body{
  overflow-x: hidden;
}

table, tr, td{
	margin: 0;
  padding: 0;
}

#writer_head{
  width: 45%;
  height: 40px;
  border-top-left-radius: 10px;
  border-top-right-radius: 10px;
  margin: 5% 0 0 28%;
  border:2px solid black;
  background: #FFD2D2;
  text-align: center;

}
#writer_head td{
  text-align: center;
  font-family: 'MaruBuri-Regular';
  font-weight: bold;
  font-size: 18px;
}

#writer_box{
  /* border: 1px solid black; */
  /* width: 100%; */
  border-top: 2px solid black;
  width: 60%;
  margin: 0 auto;
}
#writer_box .writer_box_Menu{

}
#writer_box .writer_box_Menu tr{
  border: 3px;
}
#writer_box .writer_box_Menu td{
  border: 3px;
  font-family: 'MaruBuri-Regular';
  font-weight: bold;
}
#writer_box .writer_box_Menu input{
  width: 70%;
  margin-left: 17px;
  border: 0;
  height: 35px;
}
#writer_box .writer_box_Menu td{
  width: 32%;
  height: 50px;
  border-bottom: 2px solid black;
}
#writer_box .writer_box_Menu textarea{
  margin: 5px 0 0 17px;
  border-radius: 10px;
  border: 2px solid gray;
  width: 90%;
  height: 80px;
}

#buttons{
  position: absolute;
  right: 20%;
  margin-right: 10px;
}
#buttons input{
  margin-left: 14px;
  border-radius: 10px;
  height: 30px;
  font-family: 'MaruBuri-Regular';
  font-size: 17px;
  font-weight: bold;
  background: #FFD2D2;
}
#buttons input:hover{
  background: #666b6a;
  color: #fff;
}

</style>
</head>
<body>

</body>
</html>