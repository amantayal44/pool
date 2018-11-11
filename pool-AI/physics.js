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
function pocket(ball)
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
                          ball[0].x = width/4;
                          ball[0].y = height/2;
                          if(ball[0].r!=ball_r)
                              ball[0].r=ball[0].r+1;
                          }
                       }
   
                  }
             } 
console.log("pocket"); 
return ball;
}
/////////////----Wall-Collision----/////////////////////////////////////
function col_side(ball)
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
return ball;
}
///////////////--------Overlapping--------////////////////////////////////////
function overlapping_balls(ball,i,j)
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
return ball;
}
//////////////////--------------Collision------------------////////////////////////////////
function collision(ball)
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
	   ball=overlapping_balls(ball,i,j);
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
return ball;
}
/////////////////////////////////////////////////////////////////////////////////////////
function updatepos(ball,t)
{ 
   for (i=0; i< n+1; i++)
   {
	ball[i].x = changepos(ball[i].x,ball[i].vx,ball[i].vy,t);
	ball[i].y = changepos(ball[i].y,ball[i].vy,ball[i].vx,t);
	ball[i].vx = changev(ball[i].vx,ball[i].vy,t);
	ball[i].vy = changev(ball[i].vy,ball[i].vx,t);
   }
return ball;
}

