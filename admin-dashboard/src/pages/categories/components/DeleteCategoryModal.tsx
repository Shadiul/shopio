import NiceModal, { useModal } from "@ebay/nice-modal-react";
import { Close } from "@mui/icons-material";
import {
  Button,
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
  IconButton,
  Typography,
} from "@mui/material";
import { useState } from "react";
import { firestore } from "../../../configs/firebase";
import { ICategory } from "../../../interfaces/ICategory";
import { IProduct } from "../../../interfaces/IProduct";

type DeleteProductsProps = { category: ICategory };

const DeleteProductModal = NiceModal.create<DeleteProductsProps>(
  ({ category }) => {
    const modal = useModal();

    const [loading, setLoading] = useState(false);

    const deleteProduct = async () => {
      setLoading(true);

      await firestore.collection("categories").doc(category.id).delete();
      modal.remove();

      setLoading(false);
    };

    return (
      <Dialog open={modal.visible} onClose={modal.remove}>
        <div className="flex justify-between items-center gap-2">
          <DialogTitle>Delete Category?</DialogTitle>

          <DialogActions>
            <IconButton onClick={modal.remove}>
              <Close />
            </IconButton>
          </DialogActions>
        </div>

        <DialogContent className="flex flex-col gap-4">
          <Typography>Do you really want to delete this category?</Typography>
          <Typography>Category details:</Typography>
          <Typography>ID: {category.id}</Typography>
          <Typography>Name: {category.name}</Typography>
        </DialogContent>

        <DialogActions>
          <Button
            variant="contained"
            onClick={() => modal.remove()}
            disabled={loading}
          >
            Cancel
          </Button>
          <Button
            type="submit"
            variant="contained"
            color="error"
            onClick={async () => {
              await deleteProduct();
            }}
            disabled={loading}
          >
            Delete
          </Button>
        </DialogActions>
      </Dialog>
    );
  }
);

export default DeleteProductModal;
