import React, { useEffect, useState } from 'react'

// import "./styles.css";

import { Line } from "react-chartjs-2";
import 'chart.js/auto';
import axios from 'axios';

const gridStyle = {
    display: 'grid',
    gridTemplateColumns: '1fr 1fr', // Two columns of equal width
    gridGap: '20px', // Spacing between the charts
    padding: '20px', // Padding around the grid

};
const Line2 = () => {

    const [clicks, setclicks] = useState([0])
    const [angles, setangles] = useState([0])
    const [vshakes, setvshakes] = useState([0])
    const [hshakes, sethshakes] = useState([0])
    const [xaxes, setxaxes] = useState([0])
    useEffect(() => {
        const fetchData = async () => {

            try {
                // Make the GET request
                const response = await axios.get('http://localhost:5000/data');
                const tracking_data = response.data.tracking_data
                setclicks(prev => [...prev, response.data.tracking_data[tracking_data.length - 1].clicks])
                setangles(prev => [...prev, response.data.tracking_data[tracking_data.length - 1].wrist_angle])
                setvshakes(prev => [...prev, response.data.tracking_data[tracking_data.length - 1].vertical_shakes])
                sethshakes(prev => [...prev, response.data.tracking_data[tracking_data.length - 1].horizontal_shakes])
                setxaxes(prev => [...prev, response.data.hits])
                console.log(response.data);

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

    const data1 = {
        labels: xaxes,
        datasets: [{
            label: 'Clicks',
            data: clicks,
            backgroundColor: 'blue',
            borderColor: 'blue',
            borderWidth: 3,
            lineTension: 0.8,
            pointRadius: 0, // Remove points
        pointHitRadius: 0
        }]
    };
    const data2 = {
        labels: xaxes,
        datasets: [{
            label: 'Angle',
            data: angles,
            backgroundColor: 'orange',
            borderColor: 'orange',
            borderWidth: 3,
            lineTension: 0.8,
            pointRadius: 0, // Remove points
        pointHitRadius: 0
        }]
    };
    const data3 = {
        labels: xaxes,
        datasets: [{
            label: 'Horizontal shakes',
            data: hshakes,
            backgroundColor: 'green',
            borderColor: 'green',
            borderWidth: 3,
            lineTension: 0.8,
            pointRadius: 0, // Remove points
        pointHitRadius: 0
        }]
    };
    const data4 = {
        labels: xaxes,
        datasets: [{
            label: 'Vertical Shakes',
            data: vshakes,
            backgroundColor: 'red',
            borderColor: 'red',
            borderWidth: 3,
            lineTension: 0.8,
            pointRadius: 0, // Remove points
        pointHitRadius: 0
        }]
    };

    const options = {
        scales: {
            x: {  // 'x' specifies the x-axis
                // type: 'category',
                title: {
                    display: true,
                    text: 'Time in Seconds',
                  },
                grid: {
                    display: false, // Hide grid lines for the x-axis
                },
                ticks: {
                    font: {
                        weight: 'bold', // Make Y-axis labels bold
                    },
                },
                // additional options here
            },
            y: {  // 'y' specifies the y-axis
                title: {
                    display: true,
                    text: 'Value',
                  },
                grid: {
                    display: false, // Hide grid lines for the x-axis
                },
                beginAtZero: true,
                ticks: {
                    font: {
                        weight: 'bold', // Make Y-axis labels bold
                    },
                },
                // additional options here
            }
        },
        maintainAspectRatio: true,
        plugins: {
            legend: {
                display: true,
                labels: {
                    font: {
                        size: 14, // You can also adjust the font size if needed
                        weight: 'bold', // Ensure this is applied to make legend text bold
                    },
                },
            },
        },
    };
    const chartContainerStyle = {
        width: '600px',  // Set the width of the chart
        height: '200px', // Set the height of the chart
        marginTop: '-60px',
    };

    const styles = {
        grid: {
            display: 'grid',
            gridTemplateColumns: '1fr 1fr', // 2 columns grid
            gridGap: '20px', // space between charts
            padding: '20px',
            height: '100vh', // Adjust based on your layout needs
            margin: 'auto', // Centers the grid horizontally in the outer container
            position: 'absolute', // Allows for more control over positioning
            top: '65%', // Move the top edge to the middle of the container
            left: '50%', // Move the left edge to the middle of the container
            transform: 'translate(-50%, -50%)', // Center the grid itself,
            marginBottom: '10px',
            
        },

    };
    return (
        <>
            <div className="bg-lime-200 min-h-screen">
                <h1 className="text-3xl font-bold text-center bg-sky-200 p-2">Analysis of pen clicks</h1>
                

                <div style={styles.grid} className=''>
                    <div style={chartContainerStyle} className=''> <Line data={data1} options={options} /> Clicks Over Time: Track pen activations and deactivations to understand usage patterns.
                    </div>
                    <div style={chartContainerStyle}> <Line data={data2} options={options} />Wrist Angles Over Time: Monitor pen angle to optimize ergonomic practices during usage.
                    </div>
                    <div style={chartContainerStyle} className=''> <Line data={data3} options={options} /> Horizontal Shakes Per Second: Analyze horizontal shaking frequency for insights into pre-action behaviors.
                    </div>
                    <div style={chartContainerStyle}> <Line data={data4} options={options} />Vertical Shakes Per Second: Evaluate vertical shaking movements to enhance action detection accuracy.
                    </div>



                </div>
            </div>
        </>
    )
}

export default Line2