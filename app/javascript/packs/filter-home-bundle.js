import ReactOnRails from 'react-on-rails';

import FilterHome from '../bundles/Filter/components/FilterHome';
import Search from '../bundles/Filter/components/Search';
import Submission from '../bundles/Filter/components/Submission';
import Pagination from '../bundles/Filter/components/Pagination';
import ImageLoader from '../bundles/Filter/components/ImageLoader';

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  FilterHome,
  Search,
  Submission,
  Pagination,
  ImageLoader
});
