import React from 'react';
import { VictoryBar, VictoryChart, VictoryAxis, VictoryPie } from 'victory';

export default class DataVis extends React.Component {
  constructor(props) {
    super(props);
  }
    
  render() {
    const dailyData = this.props.submissionsData != "undefined" ? this.props.submissionsData.byMonth : []
    const typeDate = this.props.submissionsData != 'undefined' ? this.props.submissionsData.types : []
    return (
      <div>
        {/* // Bar Chart... */}
        <h1 className="f2 f1-l lh-title mb0 mt4">Submission numbers in last year</h1>
        <VictoryChart
          className="mv0"
          domainPadding={10}
        >
          <VictoryAxis 
            style={{tickLabels: {fill: "#bbbbbb", fontSize: 8}}} />
          <VictoryBar
            data={dailyData}
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

        {/* Doughnut chart... */}
        <div className="w-40 pt4">
          <VictoryPie
            colorScale={["#00b753", "#38A1F3", "#B23121", "#833AB4"]}
            data={typeDate}
            labelRadius={140}
            radius={200}
            innerRadius={130}
            style={{ labels: { fill: "white", fontSize: 12, fontWeight: "" } }}
          />
        </div>
      </div>
    )
  }
}