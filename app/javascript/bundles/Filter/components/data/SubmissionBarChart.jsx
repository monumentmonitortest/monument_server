import React from 'react';
import { VictoryBar, VictoryChart, VictoryAxis } from 'victory';


export default class SubmissionBarChart extends React.Component {
  constructor(props) {
    super(props);
  }
  
  render() {
    return (
      <div>
        <h1 className="f2 f1-l lh-title mb0 mt4">Submission numbers in last year</h1>
        <VictoryChart
          className="mv0"
          domainPadding={10}
        >
          <VictoryAxis 
            style={{tickLabels: {fill: "#bbbbbb", fontSize: 8}}} />
          <VictoryBar
            data={this.props.data}
            labels={({ datum }) => `${Math.floor(datum.y)}`}
            animate={{
              duration: 2000,
              // onLoad: { duration: 1000 }
            }}
            barRatio={0.8}
            alignment="middle"
            style={{
              data: { fill: ({ datum }) => datum.y > 0 ? "#bbbbbb" : "#dcdbdb" },
              labels: { fontSize: 8, fill: "#bbbbbb"},
              parent: { border: "1px solid #ccc" },
              x: { fill:  "#bbbbbb"}
            }}
          />
        </VictoryChart>
      </div>
    )
  }
}