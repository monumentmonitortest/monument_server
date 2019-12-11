import React from 'react';
import { VictoryChart, VictoryStack, VictoryVoronoiContainer } from 'victory';

export default class SubmissionAreaChart extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      activeX: null
    };
    this.setActiveX = this.onActivated.bind(this);
  }

  onActivated(points, props) {
    this.setState({ activeX: points[0]._x });
  }
  
  render() {
    return (
      <VictoryChart
        height={400}
        width={400}
        scale={{ x: "time" }}
        containerComponent={
          <VictoryVoronoiContainer onActivated={this.setActiveX} />
        }
      >
        <VictoryStack colorScale="blue">
        {/* {this.props.data.map((submission, i)=>(
          <VictoryArea
          data={}
          dataComponent={<CustomArea activeX={this.state.activeX} />}
        />))
        } */}
          

        </VictoryStack>
      </VictoryChart>
    );
  }
}