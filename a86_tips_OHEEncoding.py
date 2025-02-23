import seaborn as sns
import pandas as pd
from sklearn.preprocessing import OneHotEncoder
#Getting a dataset
my_ds=sns.load_dataset('tips')
#Initializing encoder
encoder=OneHotEncoder()
#Encoding
encoded=encoder.fit_transform(my_ds[['sex','smoker','day','time']]).toarray()
encoded_df=pd.DataFrame(encoded,columns=encoder.get_feature_names_out())
#Concatenating original columns and new columns
new_df=pd.concat([my_ds[['total_bill','tip']],encoded_df,my_ds['size']],axis=1)
#print it all out
print(new_df.head())