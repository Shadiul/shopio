import { useModal } from "@ebay/nice-modal-react";
import { Add, Delete, Edit } from "@mui/icons-material";
import {
  Chip,
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
import { IProduct } from "../../interfaces/IProduct";
import CreateProductModal from "./components/CreateProductModal";
import EditProductModal from "./components/EditProductModal";

const ProductsPage = () => {
  const [snapshot, loading, error] = useCollection(
    collection(firestore, "products")
  );

  const createProductModal = useModal(CreateProductModal);
  const editProductModal = useModal(EditProductModal);

  const deleteProduct = async (id: string) => {
    await firestore.collection("products").doc(id).delete();
  };

  return (
    <div>
      <Fab
        color="primary"
        onClick={() => createProductModal.show()}
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
              <TableCell>Description</TableCell>
              <TableCell align="right">Price</TableCell>
              <TableCell align="right">Discount</TableCell>
              <TableCell align="right">Discount Price</TableCell>
              <TableCell align="right">Stock Quantity</TableCell>
              <TableCell>Tags</TableCell>
              <TableCell>Unit</TableCell>
              <TableCell>Actions</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {snapshot?.docs.map((doc, index) => {
              const data = doc.data() as IProduct;
              const tags = data.tags;
              return (
                <TableRow key={index}>
                  <TableCell>{data.id}</TableCell>
                  <TableCell>{data.name}</TableCell>
                  <TableCell>{data.description}</TableCell>
                  <TableCell align="right">{data.price}</TableCell>
                  <TableCell align="right">{data.discount}%</TableCell>
                  <TableCell align="right">
                    {data.price - (data.price * data.discount) / 100}
                  </TableCell>
                  <TableCell align="right">{data.stock_quantity}</TableCell>
                  <TableCell>
                    <div className="flex flex-wrap gap-2">
                      {tags?.map((tag: string, index: number) => (
                        <Chip key={index} label={tag} />
                      ))}
                    </div>
                  </TableCell>
                  <TableCell>{data.unit}</TableCell>
                  <TableCell>
                    <Stack direction="row">
                      <IconButton
                        onClick={(event) => {
                          editProductModal.show({ product: data });
                        }}
                      >
                        <Edit />
                      </IconButton>
                      <IconButton
                        onClick={async (event) => {
                          await deleteProduct(data.id);
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

export default ProductsPage;
