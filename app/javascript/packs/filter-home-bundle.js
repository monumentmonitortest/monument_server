import ReactOnRails from 'react-on-rails';

import FilterHome from '../bundles/Filter/components/FilterHome';
import ResultsManager from '../bundles/Filter/components/ResultsManager';
import Submission from '../bundles/Filter/components/Submission';
import Pagination from '../bundles/Filter/components/Pagination';
import ImageLoader from '../bundles/Filter/components/ImageLoader';
import Form from '../bundles/Filter/components/Form';
import Key from '../bundles/Filter/components/Key';

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  FilterHome,
  ResultsManager,
  Submission,
  Pagination,
  ImageLoader,
  Form,
  Key
});
