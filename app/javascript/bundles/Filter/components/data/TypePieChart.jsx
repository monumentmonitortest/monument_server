import React from 'react';
import { VictoryPie } from 'victory';

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
      />
    )
  }
}