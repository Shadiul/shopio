import { useRoutes } from "react-router-dom";
import ROUTES from "./constants/routes";

function App() {
  const routes = useRoutes(ROUTES);
  return <>{routes}</>;
}

export default App;
