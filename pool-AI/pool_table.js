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

