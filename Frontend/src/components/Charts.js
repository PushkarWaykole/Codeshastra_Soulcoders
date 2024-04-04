import React, { useEffect, useState } from 'react';
import { Line } from 'react-chartjs-2';

import 'chart.js/auto'
import axios from 'axios';
import Chart from 'chart.js/auto';








const ForcastChart = () => {

  
  useEffect(() => {
    const fetchData = async () => {
      
      try {
       

      } catch (error) {
        // Handle errors
        console.error('Error fetching data:', error);
      }
    };

    // Call fetchData initially
    fetchData();
    
    // Set up the interval to call fetchData every 10 seconds
    const intervalId = setInterval(fetchData, 1000);

    // Clean up the interval to prevent memory leaks
    return () => clearInterval(intervalId);
  }, []);
  
  const data = {
    labels: ['a','b','c'],
    datasets: [
      {
        label: 'Sensor data',
        data: [1,2,3],
        backgroundColor: 'rgba(255, 99, 132, 0.2)',
        borderColor: 'blue',
        borderWidth: 4,
        lineTension: 0.4,
      },

    ],
  };

 
 

  const options = {
    annotations: {
      line1: {
        type: 'line',
        mode: 'horizontal',
        scaleID: 'y-axis-0',
        value: 40, // Y-coordinate where the line will be drawn
        borderColor: 'red', // Color of the line
        borderWidth: 2 // Width of the line
      }
    },
    maintainAspectRatio: false, // Prevent the chart from maintaining aspect ratio
     // Set the maximum width of the chart
    responsive: true ,// Allow the chart to be responsive
    title: {
      display: true,
      text: 'Live updation of data',
    },
    scales: {
      yAxes: [{
        ticks: {
          beginAtZero: true // Start the y-axis from zero
        },
        gridLines: {
          color: (context) => {
            // Change the grid line color for a specific value (e.g., 40)
            return context.tick.value === 40 ? 'red' : 'rgba(0, 0, 0, 0.1)'; // Red color for 40, default color for others
          }
        }
      }]
    }
  };
  const containerStyle = {
    minWidth: '700px' ,// Adjust the max width as needed
    minHeight: '560px' ,// Adjust the max height as needed
  };
  
  return (
    <>
      <div className="flex justify-center items-center">

        <div className="flex justify-between items-center flex-col mt-4 " >
          <div className="font-bold text-3xl text-center">Live sensor data</div>
          <div className="p-2 bg-white rounded shadow " style={containerStyle} >
            <Line data={data} options={options} />
          </div>
          {/* <div className='text-3xl font-bold'>The RUL is: {rul}</div> */}
          {/* <div>The s_data is: {sensordata}</div> */}
        </div>

        
      </div>
    </>
  );

}

export default ForcastChart;