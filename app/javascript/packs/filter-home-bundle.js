import ReactOnRails from 'react-on-rails';

import FilterHome from '../bundles/Filter/components/FilterHome';
import Search from '../bundles/Filter/components/Search';
import Submission from '../bundles/Filter/components/Submission';

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  FilterHome,
  Search,
  Submission
});
