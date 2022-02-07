import React from 'react';
import { VictoryBar, VictoryChart, VictoryAxis, VictoryGroup, VictoryLegend } from 'victory';


export default class SubmissionBarChart extends React.Component {
  constructor(props) {
    super(props);
  }
  
  render() {
    const {submissionData} = this.props
    const {participantData} = this.props
    const {color} = this.props
    const {dataName} = this.props
    return (
      <div>
        <VictoryChart
          className="mv0"
          domainPadding={10}
        >
        {/* <VictoryLegend x={125} y={10}
          orientation="horizontal"
          gutter={20}
          colorScale={[ "#E7ECEF", "#379392"]}
          style={{ fontSize: 12 }}
          data={[
            { name: dataName, labels: {fill: "#E7ECEF"}}
          ]}
        /> */}

          <VictoryAxis 
            style={{tickLabels: {fill: "#E7ECEF", fontSize: 8}}} />
          <VictoryGroup offset={10} style={{ data: { width: 10 } }} colorScale={[color]} >
            <VictoryBar
              data={submissionData}
              labels={({ datum }) => `${Math.floor(datum.y)}`}
              animate={{
                duration: 2000,
                // onLoad: { duration: 1000 }
              }}
              barRatio={0.8}
              alignment="middle"
              style={{
                labels: { fontSize: 8, fill: "#E7ECEF"}
              }}
            />

            {/* <VictoryBar
              data={participantData}
              labels={({ datum }) => `${Math.floor(datum.y)}`}
              animate={{
                duration: 2000,
              }}
              barRatio={0.8}
              alignment="middle"
              style={{
                labels: { fontSize: 8, fill: "#379392"}
              }}
            /> */}
          </VictoryGroup>
        </VictoryChart>

      </div>
    )
  }
}