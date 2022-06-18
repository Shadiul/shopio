import { useModal } from "@ebay/nice-modal-react";
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
import { ICategory } from "../../interfaces/ICategory";
import CreateCategoryModal from "./components/CreateCategoryModal";
import DeleteCategoryModal from "./components/DeleteCategoryModal";
import EditCategoryModal from "./components/EditCategoryModal";

const CategoriesPage = () => {
  const [snapshot, loading, error] = useCollection(
    collection(firestore, "categories")
  );

  const createCategoryModal = useModal(CreateCategoryModal);
  const editCategoryModal = useModal(EditCategoryModal);
  const deleteCategoryModal = useModal(DeleteCategoryModal);

  return (
    <div>
      <Fab
        color="primary"
        onClick={() => {
          createCategoryModal.show();
        }}
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
              <TableCell>ID</TableCell>
              <TableCell>Name</TableCell>
              <TableCell align="right">Products Count</TableCell>
              <TableCell>Actions</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {snapshot?.docs.map((doc, index) => {
              const data = doc.data() as ICategory;
              return (
                <TableRow key={index}>
                  <TableCell>{data.id}</TableCell>
                  <TableCell>{data.name}</TableCell>
                  <TableCell align="right">{data.products_count}</TableCell>
                  <TableCell>
                    <Stack direction="row">
                      <IconButton
                        onClick={(event) => {
                          editCategoryModal.show({ category: data });
                        }}
                      >
                        <Edit />
                      </IconButton>
                      <IconButton
                        onClick={async (event) => {
                          deleteCategoryModal.show({ category: data });
                        }}
                      >
                        <Delete />
                      </IconButton>
                    </Stack>
                  </TableCell>
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

export default CategoriesPage;
