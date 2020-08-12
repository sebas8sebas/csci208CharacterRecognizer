This project consists on a character recognizer where the user can 
interactively draw any English upper case character and the application is
going to detect what it is. 
<br><br>
<h3>How to run</h3>
Open the MATLAB environment and type “app” on the prompt. 
<br><br>
<h3>How to use</h3>
To draw a character, click on the button labeled “Enter Input”, a blank 
window will appear where you can draw a character, when you are done close 
the window, then click on the button  labeled “Identify Letter” and the 
application will identify the letter.
<br><br>
<h3>How to train</h3>
The character recognizer works by using a neural network classifier, the
neural network object is stored as “net.mat”. While the provided “net.mat” 
is already trained, if you want to retrain it with your own data set you 
have to run the “train.m” script and you have to save the object “net” as 
“net.mat”. For the training to work, you need to include all the training 
pictures in PNG format in a directory called “trainingData”, the pictures
for each character must be stored in a subdirectory with the character’s 
name (for example all pictures for the letter “A”, must be in a subdirectory
called “A”).
<br><br>
<h3>Training data information</h3>
I only included 3 pictures for each character in this repository to 
demonstrate how the training data was structured. The full dataset I used
can be found <a href="https://www.kaggle.com/sachinpatel21/csv-to-images"> here </a>. 


