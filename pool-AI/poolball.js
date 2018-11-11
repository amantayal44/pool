/*
////////////////////////////////////////////////
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
////////////////////////////////////////////

*/

function poolballs(brain) {
    this.balls = new Array();
    for (i = 0; i < n+1; i++)
    this.balls[i] = new newball(width/4, height/2,0,0,0,0,"white",15);
    
    //color to ball
    this.balls[0].col ="#FFFFFF";
    this.balls[1].col = "#00008B";
    this.balls[2].col = "#FFFF00";
    this.balls[3].col = "#FF0000";
    this.balls[4].col = "#FF00FF";
    this.balls[5].col = "#0000FF";
    this.balls[6].col = "#FFA000";
    //initial position to balls
    this.balls[0].x = width/4;
    this.balls[0].y = height/2;

    for(var i = 1 ;i<n+1; i++){
       this.balls[i].x = 3*width/4+((i-1)%3)*2*ball_r;
       if(i<4)
        this.balls[i].y = height/2 + ball_r;
       else  
        this.balls[i].y = height/2 - ball_r;
       //console.log(ball[i].x+"  ,  "+ball[i].y); 
    }
	

    // Is this a copy of another Bird or a new one?
    // The Neural Network is the bird's "brain"
    if (brain instanceof NeuralNetwork) {
      this.brain = brain.copy();
      this.brain.mutate(mutate);
    } else {
      this.brain = new NeuralNetwork(14, 8, 2);
    }

    // Score
    this.score = 0;
    // Fitness is normalized version of score
    this.fitness = 0;
    //how many max shots machine can try
    this.life=15;
    //count no of shots played
    this.countshots = 0;
  
}
  // Create a copy of this poolballs
  poolballs.prototype.copy = function() {
    return new poolballs(this.poolballs);
  }

  // Display balls
  poolballs.prototype.show = function() {
     
     for(i=0;i<n+1;i++)
      {
        ctx.beginPath();
        ctx.arc(this.balls[i].x,this.balls[i].y,this.balls[i].r,0,2*Math.PI);
        ctx.fillStyle = this.balls[i].col;
        ctx.fill();
      }

  }

  // This is the key function now that decides
  poolballs.prototype.think = function(){
      let inputs = new Array();
      for(var i=0;i<=6;i++)
      {
          inputs[2*i]=this.balls[i].x/width;
          inputs[2*i+1]=this.balls[i].y/height;
      }
      // Get the outputs from the network
      let action = this.brain.predict(inputs);
      // predicting v and angle!
       var v=action[0]*20*80;
       var ang=action[1]*360;
       
       this.balls[0].vx=v*Math.cos(ang*Math.PI/180);
       this.balls[0].vy=-v*Math.sin(ang*Math.PI/180);
       
       this.countshots ++;
  }
  // Update balls position based on velocity, friction,collision etc.
  poolballs.prototype.update = function(t) {
       
       this.balls = updatepos(this.balls,t);
       this.balls = pocket(this.balls);
       // to update score
       // if coloured ball is potted score +3 if white ball potted score -1
       if(this.balls[0].r==0){
           this.score -= 1;}
       for(var i = 1;i<=n;i++){
           if(this.balls[i].r==ball_r-1.5){
             this.score += 3;}
         }
                 
       if(this.balls[0].x==width/4 && this.balls[0].y==height/2){ 
          if(this.balls[0].r!=ball_r)
          this.balls[0].r=this.balls[0].r+1;
       }
       this.balls = col_side(this.balls);
       this.balls = collision(this.balls);
       //create_table();
       //showball();
       //gameOver(this.balls);
       //console.log(white_pot);

    
  }
  poolballs.prototype.check_all_ball_potted = function() {
    if(this.countshots==this.life){
      return 1;}
    var flag = 1;
    for(var i = 1;i<=n; i++){
     if(this.balls[i].r!=0){ 
       flag=0;}  
    }
    return flag;
  }
  poolballs.prototype.check_all_ball_stop = function(){
    var flag = 1;
    for(var i = 0;i<=n; i++){
     if(this.balls[i].vx!=0||this.balls[i].vy!=0){ 
       flag=0;}  
    }
    return flag;
  }
      
  //animation(){
   //this.trigger=setInterval(start_animation,40);
  //}  



