class NeuralNetwork {
  
  // The weight matrices for the input-hidden and hidden-output layers
  Matrix weights_ih,weights_ho;
  // The bias matrices for the hidden and output layers
  Matrix bias_h,bias_o;  
  // The learning rate
  float l_rate = learningRate;
  
  NeuralNetwork(int i,int h,int o) {
    
    // Initialize the weight matrices with the appropriate number of rows and columns
    weights_ih = new Matrix(h,i);
    weights_ho = new Matrix(o,h);
    
    // Initialize the bias matrices with the appropriate number of rows and columns
    bias_h= new Matrix(h,1);
    bias_o= new Matrix(o,1);
  }
  
  FloatList predict(float[] X){
    
    // Convert the input array to a matrix
    Matrix input = Matrix.fromArray(X);
    // Calculate the hidden layer values
    Matrix hidden = Matrix.multiply(weights_ih, input);
    hidden.add(bias_h);
    hidden.sigmoid();
    
    // Calculate the output layer values
    Matrix output = Matrix.multiply(weights_ho,hidden);
    output.add(bias_o);
    output.sigmoid();
    
    // Convert the output matrix to an array and return it
    return output.toArray();
  }
  
  void fit(float[][]X,float[][]Y,int epochs){
    
    // Train the network for the specified number of epochs
    for(int i=0;i<epochs;i++)
    {  
      // Select a random sample from the training data
      int sampleN =  (int)(Math.random() * X.length );
      // Train the network on the sample
      this.train(X[sampleN], Y[sampleN]);
    }
  }
  
  void train(float [] X,float [] Y){
    
    // Convert the input array to a matrix
    Matrix input = Matrix.fromArray(X);
    // Calculate the hidden layer values
    Matrix hidden = Matrix.multiply(weights_ih, input);
    hidden.add(bias_h);
    hidden.sigmoid();
    
    // Calculate the output layer values
    Matrix output = Matrix.multiply(weights_ho,hidden);
    output.add(bias_o);
    output.sigmoid();
    
    // Convert the target array to a matrix
    Matrix target = Matrix.fromArray(Y);
    
    // Calculate the error between the target and output values
    Matrix error = Matrix.subtract(target, output);
    // Calculate the gradient of the output layer
    Matrix gradient = output.dsigmoid();
    gradient.multiply(error);
    gradient.multiply(l_rate);
    
    // Calculate the weight and bias updates using the hidden layer values
    Matrix hidden_T = Matrix.transpose(hidden);
    Matrix who_delta =  Matrix.multiply(gradient, hidden_T);
    
    // Update the weights and biases of the output layer
    weights_ho.add(who_delta);
    bias_o.add(gradient);
    
    // Calculate the hidden layer errors
    Matrix who_T = Matrix.transpose(weights_ho);
    Matrix hidden_errors = Matrix.multiply(who_T, error);
    
    // Calculate the gradient of the hidden layer
    Matrix h_gradient = hidden.dsigmoid();
    h_gradient.multiply(hidden_errors);
    h_gradient.multiply(l_rate);
    
    // Calculate the weight and bias updates using the input layer values
    Matrix i_T = Matrix.transpose(input);
    Matrix wih_delta = Matrix.multiply(h_gradient, i_T);
    
    // Update the weights and biases of the hidden layer
    weights_ih.add(wih_delta);
    bias_h.add(h_gradient);
    
  }
}
