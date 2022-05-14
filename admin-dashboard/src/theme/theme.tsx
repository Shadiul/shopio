import { createTheme } from "@mui/material";

const THEME = createTheme({
  components: {
    MuiDrawer: {
      defaultProps: {},
      styleOverrides: {
        paper: { width: "256px", padding: "16px" },
        root: { width: "256px" },
      },
    },
    MuiDialogActions: {
      styleOverrides: { root: { padding: "24px" } },
    },
  },
});

export default THEME;
