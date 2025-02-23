import pandas as pd
import seaborn as sns
d_f=sns.load_dataset('tips')
mean_total_bill=d_f.groupby('time')['total_bill'].mean().to_dict()
d_f['time_encoded']=d_f['time'].map(mean_total_bill)
new_df=pd.concat([d_f[['total_bill','tip','sex','smoker','day']],
                  d_f[['time_encoded']],
                  d_f[['size']]],axis=1)
print(new_df.head())
