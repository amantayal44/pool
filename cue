<!DOCTYPE html>
 <head>
 <meta charset="UTF-8"> 
</head>
<body style="font-family:sans-serif; font-size:15px; width:800px; margin-left:auto; margin-right:auto; margin-top:150px">
<center><h1>POOL GAME</h1></center>
<canvas id="mycanvas" width ="840" height="420" style="border:2px solid #000000;"></canvas>
<br>
<br>
<center>
<br>
<input id="velocity" type="range" min="0.1" max="20" step="0.1" value="20">
<p>Velocity: <span id="slider1"></span></p>
<input id="angle" type="range" min="-180" max="180" value="0">
<p>Angle: <span id="slider2"></span></p>
<br>
<input id="start" value="Play" onclick="play()" type="button">
</center> 
</body>
<script>
var radius = 30;
var ball_r = 15;
var t_sides = 5;
var width=840;
var height = 420;
var n = 6;  //n = no. of balls
var f = 40; //deacceleration due to friction
var e1 = 0.5; //e for balls
var e2 = 0.5; //e for edges
var potx = new Array(2);
var poty = new Array(2);
for(var i=0; i<2; i++)
  {
   potx[i]= new Array(3);
   poty[i]= new Array(3);
  }
var c = document.getElementById("mycanvas");
var ctx = c.getContext("2d");
function create_table(){
ctx.fillStyle = "#CA5A2F";
ctx.fillRect(0,0,width,height);
ctx.fillStyle = "#00CC00";
ctx.fillRect(radius+t_sides,radius+t_sides,width-2*(radius+t_sides),height-2*(radius+t_sides));
ctx.beginPath();
ctx.lineWidth= "2";
ctx.strokeStyle = "#000000";
ctx.rect(radius+t_sides,radius+t_sides,width-2*(radius+t_sides),height-2*(radius+t_sides));
ctx.stroke();
for(i=0;i<2;i++)
{
  potx[i][0]=t_sides+radius;
  potx[i][1]=width/2;
  potx[i][2]=width - (t_sides+radius);
}
for(i=0;i<3;i++)
{
  poty[0][i]=t_sides+radius;
  poty[1][i]=height-(t_sides+radius);
}
for(i=0;i<2;i++)
{
   for(var j=0;j<3;j++)
   {
      ctx.beginPath();
      ctx.arc(potx[i][j],poty[i][j],radius,0,2*Math.PI);
      ctx.fillStyle = "#000000";
      ctx.fill();
   }
}
}
//////////////////////////////////////Array-Object/////////////////////////////////////
function newball(x,y,vx,vy,ax,ay,col,r){
		this.x = x;
		this.y = y;
		this.vx = vx;
		this.vy = vy;
		this.ax = ax;
		this.ay = ay;
		this.col = col;
		this.r = r;
			}
var ball = new Array();
for (i = 0; i < n+1; i++)
ball[i] = new newball(width/4, height/2,0,0,0,0,"white",15);
//////////////////////////////////////////////////////////////////////////////////////
//////color to ball////////////
ball[0].col ="#FFFFFF";
ball[1].col = "#00008B";
ball[2].col = "#FFFF00";
ball[3].col = "#FF0000";
ball[4].col = "#FF00FF";
ball[5].col = "#0000FF";
ball[6].col = "#FFA000";
//////////////////////////////
function inwhite()
{
  ball[0].x = width/4;
  ball[0].y = height/2;
}
function initial()
{
for(var i = 1 ;i<n+1; i++){
ball[i].x = 3*width/4+((i-1)%3)*2*ball_r;
if(i<4)
ball[i].y = height/2 + ball_r;
else 
ball[i].y = height/2 - ball_r;
console.log(ball[i].x+"  ,  "+ball[i].y); 
}
inwhite();
}
function showball()
{
      for(i=0;i<n+1;i++)
      {
        ctx.beginPath();
        ctx.arc(ball[i].x,ball[i].y,ball[i].r,0,2*Math.PI);
        ctx.fillStyle = ball[i].col;
        ctx.fill();
      }
}
function start()
{
  initial();
  create_table();
  moveCue();
console.log("**");
  showball();

}
start();
var v, ang;
var slider1 = document.getElementById("velocity");
var output1 = document.getElementById("slider1");
output1.innerHTML = slider1.value;
v=slider1.value;
slider1.oninput = function() {
  output1.innerHTML = this.value;
}
var slider2 = document.getElementById("angle");
var output2 = document.getElementById("slider2");
output2.innerHTML = slider2.value;
ang=slider2.value;
slider2.oninput = function() {
  output2.innerHTML = this.value;
}
for(i=1;i<n+1;i++){
  ball[i].vx=0;
  ball[i].vy=0;
}
//////////////------------Changepos------------//////////////////////////////////////////////
function changepos(x,vx,vy,dt)
{
   if(vx==0)
   ax=0;
   else{
   ax=-vx*f/Math.sqrt(vx*vx+vy*vy);
   }
   x=x+vx*dt+(ax*dt*dt)/2;
   console.log("changeposition");
   return x;
}
/////////////////--------Changev----------//////////////////////////////////////////////////
function changev(vx,vy,dt)
{
   if(vx==0)
   ax=0;
   else{
   ax=-vx*f/Math.sqrt(vx*vx+vy*vy);
   } 
   console.log("changevelocity");   
   return vx+ax*dt;
}
var white_pot = 0;
////////////////////////////////////////////////////////////////////
function pocket()
{
   for(i=1;i<n+1;i++)
      {
         for(j=0;j<2;j++)
            {
               for(var k=0;k<3;k++)
                  {
                     if((ball[i].x-potx[j][k])*(ball[i].x-potx[j][k])+(ball[i].y-poty[j][k])*(ball[i].y-poty[j][k])<radius*radius){
			ball[i].vx = 0;
			ball[i].vy = 0;
		      if(ball[i].r!=0)
                       ball[i].r=ball[i].r-1.5;}
                  }
             }
       }
   for(j=0;j<2;j++)
            {
               for(var k=0;k<3;k++)
                  {
                     if((ball[0].x-potx[j][k])*(ball[0].x-potx[j][k])+(ball[0].y-poty[j][k])*(ball[0].y-poty[j][k])<=radius*radius){
                        ball[0].vx = 0;
			ball[0].vy = 0;
                        white_pot=1;
                        console.log(ball[0].r);                       
                        if(ball[0].r!=0)
                        ball[0].r=ball[0].r-1.5;
                        else{
                          inwhite();
                          if(ball[0].r!=ball_r)
                              ball[0].r=ball[0].r+1;
                          }
                       }
   
                  }
             } 
console.log("pocket"); 
}
/////////////----Wall-Collision----/////////////////////////////////////
function col_side()
{
    for(var i=0; i<n+1;i=i+1){
     if(ball[i].r==ball_r&&(i>0||white_pot==0)){
	if(ball[i].x<=radius+t_sides+ball_r)
         {
              ball[i].x=radius+t_sides+ball_r;
              ball[i].vx=-e2*ball[i].vx;
          }
	if(ball[i].x>=width-t_sides-ball_r-radius)
      {
          ball[i].x=width-t_sides-ball_r-radius;
           ball[i].vx=-e2*ball[i].vx;
      }
        if(ball[i].y<=radius+t_sides+ball_r)
         {
              ball[i].y=radius+t_sides+ball_r;
              ball[i].vy=-e2*ball[i].vy;
          }
        if(ball[i].y>=height-t_sides-ball_r-radius)
      {
           ball[i].y=height-t_sides-ball_r-radius;
           ball[i].vy=-e2*ball[i].vy;
      }
	}
}
console.log("Wall-collision");
}
///////////////--------Overlapping--------////////////////////////////////////
function overlapping_balls(i,j)
{
        var error = 1;
	var dis=Math.sqrt((ball[i].x-ball[j].x)*(ball[i].x-ball[j].x)+(ball[i].y-ball[j].y)*(ball[i].y-ball[j].y));
	var change=((2*ball_r)-dis+error)/2; //change is always either positive or zero whenever this function is called
	var t=(ball[i].y-ball[j].y)/(ball[i].x-ball[j].x);
		//changes x of both the balls
	if (ball[i].x < ball[j].x){
		ball[i].x-=(change)/Math.sqrt(1+t*t);
		ball[j].x+=(change)/Math.sqrt(1+t*t);
	}
	else if (ball[j].x < ball[i].x){
		ball[j].x-=(change)/Math.sqrt(1+t*t);
		ball[i].x+=(change)/Math.sqrt(1+t*t);
	}
	else if(ball[j].x == ball[i].x){
		if (ball[i].y< ball[j].y){
		ball[i].y-=(change);
		ball[j].y+=(change);
		}
		else if (ball[j].y< ball[i].y){
		ball[j].y-=(change);
		ball[i].y+=(change);
		}
	}
                //changes y of both the balls
	if (ball[i].y< ball[j].y){
		ball[i].y-=(change)*(Math.abs(t))/Math.sqrt(1+t*t);
		ball[j].y+=(change)*(Math.abs(t))/Math.sqrt(1+t*t);
	}
	else if (ball[j].y< ball[i].y){
		ball[j].y-=(change)*(Math.abs(t))/Math.sqrt(1+t*t);
		ball[i].y+=(change)*(Math.abs(t))/Math.sqrt(1+t*t);
	}
	else if(ball[j].y == ball[i].y){
		if (ball[i].x< ball[j].x){
		ball[i].x-=(change);
		ball[j].x+=(change);
		}
		else if (ball[j].y< ball[i].y){
		ball[j].x-=(change);
		ball[i].x+=(change);
		}
	}
}
//////////////////--------------Collision------------------////////////////////////////////
function collision()
{
  for(i = 0 ; i< n+1 ; i++)
    {
    if(i>0||white_pot==0){
      for(j = i+1 ; j< n+1 ; j++)
     if(ball[i].r==ball_r&&ball[j].r==ball_r){
      { if(((ball[i].x - ball[j].x)*(ball[i].x - ball[j].x) + (ball[i].y - ball[j].y)*
	(ball[i].y - ball[j].y)) <= 4*ball_r*ball_r &&(ball[i].r!=0)&&(ball[j].r!=0))
         { 
	   if (ball[i].x != ball[j].x)
	   {var p = (ball[j].y-ball[i].y)/(ball[j].x-ball[i].x);
           var uc1 = ball[i].vx/Math.sqrt(1 + p*p) + ball[i].vy*p/Math.sqrt(1 + p*p);
           var uc2 = ball[j].vx/Math.sqrt(1 + p*p) + ball[j].vy*p/Math.sqrt(1 + p*p);
           var up1 = ball[i].vy/Math.sqrt(1 + p*p) - ball[i].vx*p/Math.sqrt(1 + p*p);
           var up2 = ball[j].vy/Math.sqrt(1 + p*p) - ball[j].vx*p/Math.sqrt(1 + p*p);
	   var vc1 = (1-e1)*uc1/2 + (1+e1)*uc2/2;
           var vc2 = (1-e1)*uc2/2 + (1+e1)*uc1/2;
	   ball[j].vx = vc2/Math.sqrt(1 + p*p) - up2*p/Math.sqrt(1 + p*p);
	   ball[i].vx = vc1/Math.sqrt(1 + p*p) - up1*p/Math.sqrt(1 + p*p);
	   ball[i].vy = up1/Math.sqrt(1 + p*p) + vc1*p/Math.sqrt(1 + p*p);
	   ball[j].vy = up2/Math.sqrt(1 + p*p) + vc2*p/Math.sqrt(1 + p*p);
	   overlapping_balls(i,j);
	}
	   	
	   if (ball[i].vx!=0)
	ball[i].ax = -f*ball[i].vx/Math.sqrt(ball[i].vx*ball[i].vx+ball[i].vy*ball[i].vy);
	   if (ball[i].vy!=0)
	ball[i].ay = -f*ball[i].vy/Math.sqrt(ball[i].vx*ball[i].vx+ball[i].vy*ball[i].vy);
	   if (ball[i].vx==0 && ball[i].vy==0)
	{ball[i].ax = 0;ball[i].ay = 0;}
	   if (ball[j].vx!=0)
	ball[j].ax = -f*ball[j].vx/Math.sqrt(ball[j].vx*ball[j].vx+ball[j].vy*ball[j].vy);
	   if (ball[j].vy!=0)
	ball[j].ax = -f*ball[j].vy/Math.sqrt(ball[j].vx*ball[j].vx+ball[j].vy*ball[j].vy);
	   if (ball[j].vx==0 && ball[j].vy==0)
	{ball[j].ax = 0;ball[j].ay = 0;}
	}
        }
	}
     }
}
    
console.log("collision");
}
/////////////////////////////////////////////////////////////////////////////////////////
function update(t)
{ 
   for (i=0; i< n+1; i++)
   {
	ball[i].x = changepos(ball[i].x,ball[i].vx,ball[i].vy,t);
	ball[i].y = changepos(ball[i].y,ball[i].vy,ball[i].vx,t);
	ball[i].vx = changev(ball[i].vx,ball[i].vy,t);
	ball[i].vy = changev(ball[i].vy,ball[i].vx,t);
   }
}
var trigger,rotate;
function gameOver()
{
        var gameover=1;
  	for (i=1;i<n+1;i++)
		if (ball[i].r!=0) gameover=0;
        console.log(gameover);
	if (gameover==1){
		clearInterval(trigger);
                create_table();
		var c = document.getElementById("mycanvas");
		var ctx = c.getContext("2d");
		ctx.font = "30px Arial";
		ctx.strokeStyle = "red";
		ctx.strokeText("Game Over", 350, 210); 
	}
}
function start_animation()
{
    
       
       update(0.02);
       pocket();
      if(ball[0].x==width/4 && ball[0].y==height/2){ 
        if(ball[0].r!=ball_r)
          ball[0].r=ball[0].r+1;
      }
       col_side();
       collision();
       create_table();
       showball();
       gameOver();
       console.log(white_pot);
}
function animation()
{
    
     trigger=setInterval(start_animation,40);
 /* var flag2=0;          
   for(var i=0;i<n+1;i++){
        if(Math.abs(ball[i].vx)>1||Math.abs(ball[i].vy)>1) flag2=1;
  console.log("..");
      }
  console.log(flag2+"<-flag2");
	if (flag2==0) {

	clearInterval(trigger);
	moveCue(); }*/
     
}
function play()
{
	clearInterval(rotate);
   var flag=0;          
   for(var i=0;i<n+1;i++){
        if(Math.abs(ball[i].vx)>1||Math.abs(ball[i].vy)>1) flag=1;
      }

   if(flag==1)
     alert("Have patience. Let all the balls stop :)");
  else if(ball[0].r==ball_r){
   white_pot=0;
   v=slider1.value*80;
   ang=slider2.value;
   ball[0].vx=v*Math.cos(ang*Math.PI/180);
   ball[0].vy=-v*Math.sin(ang*Math.PI/180);
   clearInterval(trigger);
   create_table();
   showball();
   animation();

  }
} 
function createCue(){
  	create_table();
  	showball();
	var a=30,l=200;
	//console.log(slider2.value);
   	var slider2 = document.getElementById("angle");
	ang=slider2.value;
	ctx.beginPath();
	ctx.moveTo(ball[0].x-(a+l)*Math.cos(ang*Math.PI/180),ball[0].y+(a+l)*Math.sin(ang*Math.PI/180));
	ctx.lineTo(ball[0].x-(a)*Math.cos(ang*Math.PI/180),ball[0].y+(a)*Math.sin(ang*Math.PI/180));
	ctx.lineWidth=10;
	ctx.strokeStyle = '#DEB887';
	ctx.stroke();

	
}

function moveCue(){
	rotate =setInterval(createCue,40);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////


 </script>
</html>

