import React, { FC, useState } from "react";
import { Outlet } from "react-router-dom";
import AppBar from "./AppBar";
import Drawer from "./Drawer";

type LayoutProps = {};

const Layout: FC<LayoutProps> = () => {
  const [drawerOpen, setDrawerOpen] = useState(false);
  const toggleDrawer = () => setDrawerOpen(!drawerOpen);

  return (
    <div className="h-screen flex">
      <Drawer open={drawerOpen} onClose={toggleDrawer} />
      <div className="flex-1 ">
        <AppBar toggleDrawer={toggleDrawer} />

        <div className="p-4">
          <Outlet />
        </div>
      </div>
    </div>
  );
};

export default Layout;
