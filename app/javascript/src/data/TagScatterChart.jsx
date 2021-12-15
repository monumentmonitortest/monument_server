import React from 'react';
import { VictoryScatter, VictoryChart, VictoryTooltip, VictoryAxis } from 'victory';


const axisStyle = {
  axis: {stroke: "#756f6a"},
  axisLabel: {fontSize: 20, padding: 30, margin: 20, fill: '#efebdc'},
  grid: {stroke:  "none"},
  ticks: {stroke: "none"},
  tickLabels: {fontSize: 15, padding: 5, fill: '#efebdc'}
}

export default class TagScatterChart extends React.Component {
  constructor(props) {
    super(props);
  }
  
  render() {
    return (
      <div className="w-100 pt4">
          
          <VictoryChart 
            domainPadding={{ x: 8, y: 8 }}>
            <VictoryAxis
              label="Confidence"
              minDomain={{ x: 0 }}
              style={axisStyle}/>
            
            <VictoryAxis
              dependentAxis
              label="Tags"
              style={axisStyle}/>

            <VictoryScatter
              labelComponent={<VictoryTooltip/>}
              data={this.props.data}
              size={6}
              animate={{
                duration: 2000,
                onLoad: { duration: 1000 }
              }}
              style={{
                data: {
                  fill: "#ffffff", 
                  width: 20,
                  fillOpacity: 0.7,
                },
                grid: {stroke: 'none', fill: 'none', strokeWidth: 0},
              }}
            />
          </VictoryChart>
          
        </div>
    )
  }
}