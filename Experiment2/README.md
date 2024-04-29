# ApacheBeam

## Goal : Count the number of end devices by discovering how many devices each single address of unique device in each network could generate.

The collection of data is managed in this way:

1. Collection number one -> Elements of data base on their **network id**

      - **Input1:** The dataset.
      - <a name="Output1"><b>Output1</b></a>: Grouped the data base on the **home_network_net_id**

      1. The output of collection(Tuple of data base on network id):</br>
      *Example1*:</br>
      
           ('37', [['2023-01-04 00:00:10.140905 UTC', '6F4BFEF3', '3933', '37', 'wsloragw01']])</br>
           ('33', [['2023-01-04 00:00:10.855087 UTC', '679035BB', '9594', '33', 'eui-3436323866005100']])</br>
           ('21', [['2023-01-04 00:00:11.197833 UTC', '4329DE5F', '4716', '21', 'eui-00800000a0004e9f']])</br>
      
           🔗<a href="https://github.com/NileFiume/ApacheBeam/tree/master/outputs/collection_groupByNetwork.txt">Data grouped by network id</a></br>
      :writing_hand:The output of 'i' piped to the 'ii'(In this case, the data are in tuples and for processing as a list, process1 used).

      2. The output of list:</br>
      *Example2*:</br>
      
           ['2023-01-04 00:00:10.140905 UTC', '6F4BFEF3', '3933', '37', 'wsloragw01']</br>
           ['2023-01-04 00:00:10.855087 UTC', '679035BB', '9594', '33', 'eui-3436323866005100']</br>
           ['2023-01-04 00:00:11.197833 UTC', '4329DE5F', '4716', '21', 'eui-00800000a0004e9f']</br>
           
           🔗<a href="https://github.com/NileFiume/ApacheBeam/blob/master/outputs/list_process1.txt">List of grouped data</a></br> 

 ------------------------------------------------------------------------------------------------------------------------------
   
2. Collection number two -> Frames for each **device**
       
      - **Input2:** Output of previous collection([Link to Output1](#Output1))
      - <a name="Output2"><b>Output2</b></a>: Grouped each network data by **dev_addr**
      
      1. The output of collection:</br>
      *Example1*:</br>
      
           ('6F4BFEF3', [['2023-01-04 00:00:10.140905 UTC', '6F4BFEF3', '3933', '37', 'wsloragw01']])</br>
           ('679035BB', [['2023-01-04 00:00:10.855087 UTC', '679035BB', '9594', '33', 'eui-3436323866005100']])</br>
           ('4329DE5F', [['2023-01-04 00:00:11.197833 UTC', '4329DE5F', '4716', '21', 'eui-00800000a0004e9f']])</br>
           
           🔗<a href="https://github.com/NileFiume/ApacheBeam/tree/master/outputs/collection_groupByDevice.txt">Data grouped by device</a><br />
   --------------------------------        
      2. process2 -> There are many frames that are replicated in this process for specific gateway so 
         process2 is responsible to filter out(These are tuples of frame number and gateway_id) ;however,repeated
         frames reserved by different gateways). Moreover, the data sorted base on frame number.</br>
         
      - **Input3:** Output of previous step([Link to Output2](#Output2))
      - **Output3:** <a name="Output3"><b>Output3</b></a>:The ouptputs are **distinct frame list**.
      
         *Example1*:</br></br>
             [(3933, 'wsloragw01'), 1]</br>
             [(9594, 'eui-3436323866005100'), 1]</br>
             [(4716, 'eui-00800000a0004e9f'), 1]</br>
   
         *Example2*:</br>
      
          [(5384, 'eui-00800000a0004e9f'), (5384, 'eui-00800000a00061e3'), (5385, 'eui-00800000a00061e3'), 1]</br>
          > Therefore, Duplicated **f_cnt**(5384) are existed for different **forwarder_gateway_id**.</br>
      
         *Example3*:</br>
      
          [(57054, 'uhv3-roundtop-tower'), (57055, 'uhv3-roundtop-tower'), (57069, 'uhv3-hcc-library'), 1]</br>
           > Different **f_cnt**(57054,57055) for the same **forwarder_gateway_id**.</br>
           
         🔗<a href="https://github.com/NileFiume/ApacheBeam/tree/master/outputs/list_process2.txt">Unique frames for each gateway</a><br />

         :writing_hand:The output sorted. Considering that each of these collection related to a device, "One" at the end of each list 
         is for spotting one device and in the next process(process3) calculation about number of the devices take place.
     
      --------------------------------
      3. process3 -> Number of **devices**
         - **Input4:** Output of previous step([Link to Output3](#Output3))</br>
         - **Output4:** The number of distinct devices for devices(**dev_addr** are not unique then by taking each of them as an input</br>
         > Rules for counting frames and specify devices
         
           * Rule1: If the distance between two frames are less than our expectation then even by different **forwarder_gateway_id**
             they are all for a exclusive device.
           * Rule2: Sometimes the space between two frames is huge enough but checking the **forwarder_gateway_id** is necessary because 
             there could be some intruption between two frames of same device specially for individual gateway.
           * Rule3: If there is a session that frame inside that jump from '0' to the last one(base on definition), gateway_id specify 
             whether this is the same device or not.</br>
             
           🔗<a href="https://github.com/NileFiume/ApacheBeam/tree/master/outputs/list_process3.txt">Number of unique end devices</a>
      
       
           :writing_hand:specify whether that device address is for more than one device or not, meanwhile, the last number of list is the counter).</br>
      
            *Example1*:</br>
                    [(1457, 'eui-00800000a0004e9f'),(1458, 'eui-00800000a0004e9f'),</br>
                     (1458, 'eui-00800000a00061e0'),(1458, 'eui-00800000a00061e1'),</br>
                     (12209, 'eui-00800000a00061e0'),(41938, 'eui-00800000a0007006'), 3]</br>   
         
            > **f_cnt**(1457,1458) counted as one device, frame was recieved by two different **forwarder_gateway_id**
   
   

    
 
    
       
