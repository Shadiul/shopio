import { RouteObject } from "react-router-dom";
import Layout from "../components/layout/Layout";
import CategoriesPage from "../pages/categories/categories_page";
import DashboardPage from "../pages/dashboard/dashboard";
import ProductsPage from "../pages/products/products";
import UsersPage from "../pages/users/users_page";
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
      {
        path: PATHS.categories,
        element: <CategoriesPage />,
      },
      {
        path: PATHS.users,
        element: <UsersPage />,
      },
    ],
  },
];

export default ROUTES;
