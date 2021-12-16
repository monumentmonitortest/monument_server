import React from 'react';
import { VictoryPie, VictoryTooltip } from 'victory';

export default class TypePieChart extends React.Component {
  constructor(props) {
    super(props);
  }
  
  render() {
    return (
      <VictoryPie
        colorScale={["#00b753", "#38A1F3", "#B23121", "#833AB4"]}
        data={this.props.data}
        labelRadius={140}
        radius={200}
        innerRadius={130}
        style={{ labels: { fill: "white", fontSize: 12, fontWeight: "" } }}
        labels={({ datum }) => `${datum.x}: ${datum.y}`}
        labelComponent={
          <VictoryTooltip 
            style={{ fill: "grey", fontSize: 34  }} 
            dy={0} 
            centerOffset={{ cx: 5 }}
            constrainToVisibleArea
            pointerLength={0}
            flyoutWidth={250}
            flyoutHeight={100}/>
        }
      />
    )
  }
}