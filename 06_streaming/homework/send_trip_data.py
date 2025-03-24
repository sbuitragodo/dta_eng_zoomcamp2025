import json
import time 
import pandas as pd
from kafka import KafkaProducer

def json_serializer(data):
    return json.dumps(data).encode('utf-8')

server = 'localhost:9092'

producer = KafkaProducer(
    bootstrap_servers=[server],
    value_serializer=json_serializer
)

# Start the producer
producer.bootstrap_connected()

# Read csv data
df = pd.read_csv('green_tripdata_2019-10.csv')
data = df.drop(columns=['VendorID', 'store_and_fwd_flag', 'RatecodeID', 'fare_amount', 'extra', 'mta_tax', 'tolls_amount', 'ehail_fee', 'improvement_surcharge', 'total_amount', 'payment_type', 'trip_type', 'congestion_surcharge'])

# Send the data
t0 = time.time()

topic_name = 'green-trips'

for row in data.itertuples(index=False):
    message = {col: getattr(row, col) for col in row._fields}
    producer.send(topic_name, value=message)
    print(f"Sent: {message}")

producer.flush()

t1 = time.time()
print(f'took {(t1 - t0):.2f} seconds')