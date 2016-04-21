# Tim Goonan
# Can use for personal use, just give credit

# You have to download the train and test data off kaggle for the animal shelter competition
# You also have to import the library nnet to be able to use the multinom function


# Read the traindata in
trainData = read.csv("~/shelter_animal_train.csv", header = TRUE)

# Read the testdata in
testData = read.csv("~/shelter_animal_test.csv", header = TRUE)

# Convert the categorical response variable into numeric values, i.e, Adoption = 1
trainData$OutcomeType.f <- as.numeric(factor(trainData$OutcomeType , levels=c("Adoption","Died","Euthanasia","Return_to_owner","Transfer")))

# Fill in missing data with mode
testData$AgeuponOutcome[is.na(testData$AgeuponOutcome)] = "1 year"

# Create ID variable to be used when creating prediction columns
ID = testData$ID


# Fit a multinomial logistic regression, which does a logistic regression for mutliple responses
fit = multinom(OutcomeType.f ~ SexuponOutcome + AnimalType, data= trainData)

# Get the results and convert it into probability form
results = predict(fit, testData, "probs")

# Create columns, results is actually 5 columns
kaggle_sub = cbind(ID, results)

# Create the names for the columns, there has to be six to match kaggle_sub
colnames(kaggle_sub) = c("ID", "Adoption", "Died", "Euthanasia", "Return_to_owner","Transfer")

# Create a csv file with the column names and values, this will be used to upload onto kaggle
write.csv(kaggle_sub, file = "shelter_animal_kaggle_prediction.csv", row.names = FALSE)
