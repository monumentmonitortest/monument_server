import React from 'react';
import { VictoryBar, VictoryChart, VictoryTheme, VictoryAxis } from 'victory';

export default class DataVis extends React.Component {
  constructor(props) {
    super(props);
  }
    
  render() {
    const dailyData = this.props.submissionsData != "undefined" ? this.props.submissionsData.byMonth : []

    return (
      <div>
        <h1>Last Month</h1>
        <VictoryChart
          // theme={VictoryTheme.grayscale}
          domainPadding={10}
        >
          <VictoryAxis 
            style={{tickLabels: {fill: "#bbbbbb"}}} />
          <VictoryBar
            data={dailyData}
            labels={({ datum }) => `${datum.y}`}
            animate={{
              duration: 2000,
              onLoad: { duration: 1000 }
            }}
            barRatio={0.8}
            alignment="middle"
            style={{
              data: { fill: ({ datum }) => datum.y > 0 ? "#bbbbbb" : "#dcdbdb" },
              labels: { fontSize: ({ text }) => text.length > 10 ? 8 : 12, fill: "#bbbbbb"},
              parent: { border: "1px solid #ccc" },
              x: { fill:  "#bbbbbb"}
            }}
          />
        </VictoryChart>
      </div>
    )
  }
}