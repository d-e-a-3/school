
weightingPortion = 0.1;
weigthingFactor = 10;
A1 = ones(round(splitPoint1*(1-weightingPortion),0),1);
B1 = 5*ones(round(splitPoint1*weightingPortion,0),1);
weightingVector1 = vertcat(A1,B1);
A2 = ones(round(splitPoint2*(1-weightingPortion),0),1);
B2 = 5*ones(round(splitPoint2*weightingPortion,0),1);
weightingVector2 = vertcat(A1,B1);