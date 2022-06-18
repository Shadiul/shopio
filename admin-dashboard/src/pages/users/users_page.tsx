import { Add, Delete, Edit } from "@mui/icons-material";
import {
  Fab,
  IconButton,
  LinearProgress,
  Stack,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Typography,
} from "@mui/material";
import { collection } from "firebase/firestore";
import React from "react";
import { useCollection } from "react-firebase-hooks/firestore";
import { firestore } from "../../configs/firebase";
import { IUser } from "../../interfaces/IUser";

const UsersPage = () => {
  const [snapshot, loading, error] = useCollection(
    collection(firestore, "users")
  );

  return (
    <div>
      <Fab
        color="primary"
        onClick={() => {}}
        sx={{
          position: "absolute",
          bottom: "16px",
          right: "16px",
        }}
      >
        <Add />
      </Fab>
      <TableContainer>
        <Table>
          <TableHead sx={{ backgroundColor: "lightgray" }}>
            <TableRow>
              <TableCell>UID</TableCell>
              <TableCell>Name</TableCell>
              <TableCell>Email</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {snapshot?.docs.map((doc, index) => {
              const data = doc.data() as IUser;
              return (
                <TableRow key={index}>
                  <TableCell>{data.uid}</TableCell>
                  <TableCell>{data.name}</TableCell>
                  <TableCell>{data.email}</TableCell>
                </TableRow>
              );
            })}
          </TableBody>
        </Table>
        {loading && <LinearProgress />}
        {error && (
          <Typography color="error" textAlign="center" margin="16px">
            {error.message}
          </Typography>
        )}
      </TableContainer>
    </div>
  );
};

export default UsersPage;
