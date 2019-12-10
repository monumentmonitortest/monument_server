import React from 'react';
import * as d3 from 'd3'


export default class TagBubbleChart extends React.Component {
  constructor(props) {
    super(props);
    this.createBarChart = this.createBarChart.bind(this)
  }
  
  componentDidMount() {
    this.createBarChart()
  }

  componentDidUpdate() {
    this.createBarChart()
  }

  createBarChart() {
    const node = this.node
    const width = 934
    const height = 934
    const root = this.pack(this.props.data , width, height);
    const format = d3.format(",d")
    
    const values = this.props.data.map(x => x.value)
    const valuesLength = values.length

    // ensures that there is a consistent colour scale - however many tags there are
    const colorScale = d3.scaleLinear()
      .domain([values[0], 
               values[Math.floor(valuesLength * 0.25)], 
               values[Math.floor(valuesLength / 2)], 
               values[Math.floor(valuesLength * 0.75)], 
               values[valuesLength - 1]])
      .range(['#814ee7', '#3f24ec', '#79e87C', '#fbe157', '#fe3b3b'])

    const svg = d3.select(node)
                  .attr("viewBox", [0, 0, width, height])
                  .attr("font-size", 10)
                  .attr("font-family", "sans-serif")
                  .attr("text-anchor", "middle");
                  
    const leaf = svg.selectAll("g")
      .data(root.leaves())
      .join("g")
        .attr("transform", d => `translate(${d.x + 1},${d.y + 1})`);
  
    leaf.append("circle")
        .attr("id", d => (d.leafUid = d.text))
        .attr("r", d => d.r)
        .attr("fill-opacity", 1)
        .style("fill", d => colorScale(d.value));
  
    leaf.append("clipPath")
        .attr("id", d => (d.clipUid = d.text))
  
    leaf.append("text")
      .attr("dy", ".3em")
      .style("text-anchor", "middle")
      .style("font", "10px sans-serif")
      .style("pointer-events", "none")
      .text(function(d) { return d.data.text.substring(0, d.r / 3); });
  
    // leaf.append("title")
    //     .text(d => `${d.data.text}\n${format(d.value)}`);
  }

  pack(data, width, height) {
    const dataPack = d3.pack()
                       .size([width - 2, height - 2])
                       .padding(3)
                       (d3.hierarchy({children: data})
                       .sum(d => d.value))
    return dataPack
  }
  
  render() {
    return (
      <div>
        <svg ref={node => this.node = node}></svg>
      </div>
    )
  }

 
}