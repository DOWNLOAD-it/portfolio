import React from "react";
import ReactDOM from "react-dom/client";
import "./index.css";
import { createBrowserRouter, RouterProvider } from "react-router-dom";
import NotFound from "./components/NotFound";
import App from "./App";

const router = createBrowserRouter([
  {
    path: "/",
    Component: App,
  },
  {
    path: "*",
    Component: NotFound,
  },
]);

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  <React.StrictMode>
    <RouterProvider router={router} />
  </React.StrictMode>
);
