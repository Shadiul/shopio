import { Menu } from "@mui/icons-material";
import {
  AppBar as MuiAppBar,
  IconButton,
  Theme,
  Toolbar,
  Typography,
  useMediaQuery,
} from "@mui/material";
import React, { FC, useEffect, useState } from "react";
import { useLocation } from "react-router-dom";
import PATHS from "../../constants/paths";
type AppBarProps = {
  toggleDrawer: () => void;
};

const AppBar: FC<AppBarProps> = ({ toggleDrawer }) => {
  const isMobileScreen = useMediaQuery((theme: Theme) =>
    theme.breakpoints.down("lg")
  );

  const location = useLocation();

  const [title, setTitle] = useState<string | undefined>(undefined);
  useEffect(() => {
    setTitle(getTitleFromPathname(location.pathname));
  }, [location.pathname]);

  return (
    <MuiAppBar position="sticky" elevation={0}>
      <Toolbar>
        {isMobileScreen && (
          <IconButton onClick={toggleDrawer}>
            <Menu sx={{ color: "primary.contrastText" }} />
          </IconButton>
        )}

        <div className="w-4" />

        <Typography variant="h6" textTransform="capitalize">
          {title}
        </Typography>
      </Toolbar>
    </MuiAppBar>
  );
};

export default AppBar;

const getTitleFromPathname = (pathname: string) => {
  switch (pathname) {
    case "/":
      return "dashboard";
    case PATHS.products:
      return "products";
    case PATHS.categories:
      return "categories";
    case PATHS.users:
      return "users";
    default:
      return;
  }
};
