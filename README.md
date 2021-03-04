# PET-projects
This is my pet-projects that i have done during studing Computer Science

## Gess_number 
Gess_number is first ever project aimed on styding conditions, loops, functions. 

  This program for finding a hidden number is based on the QuickSort method.
Each time the guessed number is compared with the average value of the interval.
The interval decreases after each pass of the cycle, taking the previous average value or as the lower one
either for the upper bound. The function takes a hidden number and returns the number of attempts

## Movies_analytics

In this project I conduct preliminary data analysis based on the IMBD site dataset. 

  Main target of this project is to study simple dataframe analysis using Pandas. For example you need to know who was the highest paid film director of drama movies during 2011 year? What actors are most often filmed in the same film together? Which studio film descriptions are the longest on average in terms of word count? Which films are in the top 1 percent rated? 
  

## EDA

  Main target of this project is to conduct an intelligence analysis (EDA) of the dataset to further build a model that would predict the results of the state exam in mathematics for students in the school. The dataset contains information about 395 students. All the student have different signs such as school abbreviation, age, education of parents, travel time to school etc.


## TripAdvisior_raiting_predict

  This project aimed to properly prepare the data for training the model (Feature Engineering). One of TripAdvisor's problems is dishonest restaurants that drive up their ratings. One way to find such restaurants is to build a model that predicts the rating of a restaurant. If the predictions of the model differ greatly from the actual result, then the restaurant may be playing unfairly and should be tested.
  
  ## Bank_scoring
  
  Main task is to build a scoring model for the bank's secondary clients, which would predict the likelihood of a client's default. To do this, you will need to determine the significant parameters of the borrower in 48 hours in a hackathon format. 
  At this stage, several models were trained at once, from which the best ones were selected according to the ROC-AUC metric to find the optimal parameters of the models. The following models were evaluated:
  1. KNeighborsClassifier;
  2. GaussianNB;
  3. LogisticRegression;
  4. RandomForestClassifier;
  5. GradientBoostingClassifier;
  6. XGBClassifier;
  7. HistGradientBoostingClassifier;
  8. AdaBoostClassifier;
  10. LGBMClassifier;
  11. LogitBoost.
  
  For the best models, we searched for the optimal hyperparameters on the grid and estimated the ROC-AUC metric after optimization:
  - LogisticRegression - penalty, solver, class_weight;
  - GradientBoostingClassifier - learning_rate, n_estimators, max_depth, min_samples_split, min_samples_leaf, max_features, subsample;
  - AdaBoostClassifier + LogisticRegression - learning_rate,n_estimators, algorithm.
 
 Result
  score ROC-AUC = 0.74005
