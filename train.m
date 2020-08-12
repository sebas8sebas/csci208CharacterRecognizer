%Run this script to train neural network for character recognition and save
%the resulting object as "net.mat" in order to use the trained network in
%the character recognition GUI. 
%The provided "net.mat" file is already trained so there is no need to run
%this script unless you want to train it again.
%
%This script assumes all training images are stored in a directory called
%'trainingData' and training images gor for each letter are saved in a
%subdirectory with the letter's name (for example training images for letter 
%'A' are stored in a folder called A)
%
%References:
%https://www.mathworks.com/help/deeplearning/ug/create-simple-deep-learning-network-for-classification.html

%All training picutres must be in folders where the name of the folder is the
%name of the label of each picture
imds = imageDatastore('trainingData','IncludeSubfolders',true, 'LabelSource','foldernames', 'FileExtensions',{'.png'});
imds.ReadFcn = @customreader;

%Number of training file per letter
numTrainFiles = 1000;
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');

%Specify layers for neural networ
%Source: https://www.mathworks.com/help/deeplearning/ug/create-simple-deep-learning-network-for-classification.html
layers = [
    imageInputLayer([28 28 1]) %size of input images
    
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(26)
    softmaxLayer
    classificationLayer];


%Parameters for the neural network
%Source: https://www.mathworks.com/help/deeplearning/ug/create-simple-deep-learning-network-for-classification.html
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress');

%train neural network, after training save resulting object as "net.mat"
net = trainNetwork(imdsTrain,layers,options);  



%Custom read function
% Convert every RGB image into grayscale
% Source: https://www.mathworks.com/matlabcentral/answers/449046-how-can-i-resize-image-stored-in-imagedatastore
function data = customreader(filename)
onState = warning('off', 'backtrace');
c = onCleanup(@() warning(onState));
data = imread(filename);
data = data(:,:,min(1:3, end)); 
%data = imresize(data, [28 28]); %uncomment this if you want to resize when
%they are read
data = rgb2gray(data);  %converto to grayscale
end