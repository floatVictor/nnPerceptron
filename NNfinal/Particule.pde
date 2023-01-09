class Particule {
  
  float x, y; //Positionn(x, y)
  int type; // Type of the particle (1 or -1)
  float score; // Score of the particle (from 0 to 1)
  float hue; // Hue of the particle's color
  
  // Constructor for the particle
  Particule(float x_, float y_, int type_, float score_) {
    
    x = x_;
    y = y_;
    type = type_;
    score = score_;
    
    // Set the hue based on the type of the particle
    if (type == 1) hue = hue1;
    else hue = hue2;
  }
  
  void display(float x_, float target_) {
    
    // Calculate the size and saturation based on the score
    float scoreSize = score * (size + 0.2);
    float scoreSat = score * sat;
    
    // Set the stroke weight and color
    strokeWeight(scoreSize);
    stroke(hue, map(scoreSat*scoreSat, 0, sat*sat, 255, 0) + satOff, val, opa* (score*score) - satOff);
    
    // Draw a line with some noise  (comment this for more accurate visualisation)
    line(
      x_ + (2*noise(x_ * noiseRatioX)-1) * noiseDisplaceX,
      target_ + (2*noise(target_ * noiseRatioY)-1) * noiseDisplaceY, 
      x, y);
      
    // Turn off stroke and set fill color
    noStroke();
    fill(hue, map(scoreSat*scoreSat, 0, sat*sat, 255, 0) + satOff, val, opa);
    
    // Increase the size of the rectangle if the score is high
    if(score > 0.95 && random(1)> 0.88) scoreSize += 2;
    else if(score > 0.7 && random(1)> 0.82) scoreSize ++;
    
    // Draw the rectangle
    rect(x, y, (scoreSize * 3)*scoreSize, (scoreSize * 3)*scoreSize );
  }
}
  
/*  void displayline(float x_, float target_, float x2_, float target2_, float p2X, float p2Y) {
    float scoreSat = score * sat;
    strokeWeight(1);
    stroke(hue, map(scoreSat*scoreSat, 0, sat*sat, 255, 0) + satOff, val, opa * (score*score));
    curve(x, y, x, y, x2_, target2_, p2X, p2Y);
  }
}*/
