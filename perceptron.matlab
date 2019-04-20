function [wrongOutputs] = perceptron(TrainingSet,LEARN,EPOCHS)
numPatterns=size(TrainingSet,1);
numAttributes = size(TrainingSet,2)-1; 
BIAS =  numAttributes+1; 
Weights = rand(1,BIAS)*0.2-0.1; 
Targets = TrainingSet(:,(numAttributes+1)); 
TrainingSet = TrainingSet(:,1:numAttributes); 
wrongOutputs=0;
for epoch=1:EPOCHS
    wrongOutputs=0;
    WeightChanges = zeros(1,BIAS); 
    for row=1:numPatterns 
        net = 0;
        for i=1:numAttributes
          net = net + TrainingSet(row,i)*Weights(i);
        end
        net = net + (-1 * Weights(BIAS)); 
        neuronOutput = threshold(net);
        Error = Targets(row) - neuronOutput;
        for i=1:numAttributes
          WeightChanges(i)=WeightChanges(i)+ LEARN * Error * TrainingSet(row,i);
        end
        WeightChanges(BIAS)=WeightChanges(BIAS)+ LEARN * Error * -1; 
        if neuronOutput ~= Targets(row)
            wrongOutputs = wrongOutputs+1;
        end 
    end 
    Weights = Weights + WeightChanges; 
end 
hold on
for i=0:20
  x = i/20;
  for j=0:20 
    y = j/20;
    net = x * Weights(1) + y * Weights(2) - Weights(3);
    out = threshold(net);
   if (out==0)
     plot(x,y,'ro');
   else
    plot(x,y,'g+');
  end %if
 end %for j
end %for i
end %Function neuronFire
function [out] = threshold(net)
  %calculates neuron output given net
  if net > 0
      out = 1;
  else
      out = 0;
  end %if
end