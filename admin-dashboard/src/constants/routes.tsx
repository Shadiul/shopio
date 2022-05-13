import { RouteObject } from "react-router-dom";
import Layout from "../components/layout/Layout";
import DashboardPage from "../pages/dashboard/dashboard";
import ProductsPage from "../pages/products/products";
import PATHS from "./paths";

const ROUTES: RouteObject[] = [
  {
    path: "/",
    element: <Layout />,
    children: [
      {
        index: true,
        path: PATHS.dashboard,
        element: <DashboardPage />,
      },
      {
        path: PATHS.products,
        element: <ProductsPage />,
      },
    ],
  },
];

export default ROUTES;
