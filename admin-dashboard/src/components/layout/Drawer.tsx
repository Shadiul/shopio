import { Dashboard, ShoppingBag } from "@mui/icons-material";
import {
  Drawer as MuiDrawer,
  ListItemButton,
  ListItemIcon,
  ListItemText,
  Theme,
  Typography,
  useMediaQuery,
} from "@mui/material";
import React, { FC } from "react";
import { NavLink } from "react-router-dom";
import PATHS from "../../constants/paths";

interface IDrawerItem {
  name: string;
  icon: JSX.Element;
  path: string;
}
const DRAWER_ITEMS: IDrawerItem[] = [
  {
    name: "dashboard",
    icon: <Dashboard />,
    path: PATHS.dashboard,
  },
  {
    name: "products",
    icon: <ShoppingBag />,
    path: PATHS.products,
  },
];

type DrawerProps = {
  open: boolean;
  onClose: () => void;
};

const Drawer: FC<DrawerProps> = ({ open, onClose }) => {
  const isMobileScreen = useMediaQuery((theme: Theme) =>
    theme.breakpoints.down("lg")
  );
  return (
    <MuiDrawer
      open={open}
      onClose={onClose}
      variant={isMobileScreen ? "temporary" : "permanent"}
    >
      <Typography variant="h5">Shopio</Typography>

      <div className="h-4" />

      <div>
        {DRAWER_ITEMS.map((item, index) => (
          <NavLink
            to={item.path}
            key={index}
            onClick={isMobileScreen ? onClose : undefined}
          >
            {({ isActive }) => (
              <ListItemButton selected={isActive}>
                <ListItemIcon>{item.icon}</ListItemIcon>
                <ListItemText>
                  <Typography textTransform="capitalize">
                    {item.name}
                  </Typography>
                </ListItemText>
              </ListItemButton>
            )}
          </NavLink>
        ))}
      </div>
    </MuiDrawer>
  );
};

export default Drawer;
