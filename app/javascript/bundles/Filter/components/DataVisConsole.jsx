import React from 'react';

import SubmissionBarChart from './data/SubmissionBarChart'
// import SubmissionAreaChart from './data/SubmissionAreaChart'
import TagScatterChart from './data/TagScatterChart'
import TypePieChart from './data/TypePieChart'

export default class DataVis extends React.Component {
  constructor(props){
    super(props)
  }
  

  render() {
    const dailyData = this.props.submissionsData != "undefined" ? this.props.submissionsData.byMonth : []
    const typeData = this.props.submissionsData != 'undefined' ? this.props.submissionsData.types : []
    const tagData = this.props.submissionsData != 'undefined' ? this.props.submissionsData.tags : []
    
    return (
      <div>
        {/* <SubmissionAreaChart data={dailyData} /> */}
        <SubmissionBarChart data={dailyData} />
        <TypePieChart data={typeData} />
        <TagScatterChart data={tagData} />
      </div>
    )
  }
}