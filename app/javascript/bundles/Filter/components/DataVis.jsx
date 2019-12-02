import React from 'react';
import { VictoryBar, VictoryChart, VictoryTheme } from 'victory';

export default class DataVis extends React.Component {
  constructor(props) {
    super(props);
  }

  

  
  render() {
    const dailyData = []
    return (
      <div>
        <h1>Last Month</h1>
        <VictoryChart
          theme={VictoryTheme.material}
          domainPadding={10}
        >
          <VictoryBar
            style={{ data: { fill: "#c43a31" } }}
            data={dailyData}
            animate={{
              duration: 2000,
              onLoad: { duration: 1000 }
            }}
            barRatio={0.8}
            // labels={dailyData}
          />
        </VictoryChart>
      </div>
    )
  }
}