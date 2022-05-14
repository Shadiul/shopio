import NiceModal, { useModal } from "@ebay/nice-modal-react";
import { yupResolver } from "@hookform/resolvers/yup";
import { Close } from "@mui/icons-material";
import {
  Button,
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
  IconButton,
  TextField,
} from "@mui/material";
import { useState } from "react";
import { Controller, SubmitHandler, useForm } from "react-hook-form";
import { firestore } from "../../../configs/firebase";
import { IEditProductFormInput, IProduct } from "../../../interfaces/IProduct";
import { EDIT_PRODUCT_SCHEMA } from "../../../schemas/edit_product_schema";

type EditProductsProps = { product: IProduct };

const EditProductModal = NiceModal.create<EditProductsProps>(({ product }) => {
  const modal = useModal();

  const [loading, setLoading] = useState(false);

  const editProduct = async (data: IEditProductFormInput) => {
    setLoading(true);

    const newData = { ...data, tags: data.tags.split(",") };
    await firestore.collection("products").doc(product.id).update(newData);

    setLoading(false);
  };

  const { handleSubmit, reset, control } = useForm<IEditProductFormInput>({
    resolver: yupResolver(EDIT_PRODUCT_SCHEMA),
  });

  const onSubmit: SubmitHandler<IEditProductFormInput> = (data) => {
    editProduct(data);
    reset();
    modal.remove();
  };

  return (
    <Dialog open={modal.visible} onClose={modal.remove}>
      <div className="flex justify-between items-center gap-2">
        <DialogTitle>Edit Product</DialogTitle>

        <DialogActions>
          <IconButton onClick={modal.remove}>
            <Close />
          </IconButton>
        </DialogActions>
      </div>

      <form onSubmit={handleSubmit(onSubmit)}>
        <DialogContent className="flex flex-col gap-4">
          <Controller
            name="name"
            control={control}
            defaultValue={product.name}
            render={({ field, fieldState }) => (
              <TextField
                {...field}
                fullWidth
                label="Name"
                placeholder="Product Name"
                error={!!fieldState.error}
                helperText={fieldState.error?.message}
              />
            )}
          />

          <Controller
            name="description"
            control={control}
            defaultValue={product.description}
            render={({ field, fieldState }) => (
              <TextField
                {...field}
                fullWidth
                label="Description"
                placeholder="Product Description"
                error={!!fieldState.error}
                helperText={fieldState.error?.message}
                multiline
                rows={3}
              />
            )}
          />

          <div className="flex gap-4">
            <Controller
              name="price"
              control={control}
              defaultValue={product.price}
              render={({ field, fieldState }) => (
                <TextField
                  {...field}
                  fullWidth
                  label="Price"
                  placeholder="Product Price"
                  error={!!fieldState.error}
                  helperText={fieldState.error?.message}
                  type="number"
                />
              )}
            />
            <Controller
              name="discount"
              control={control}
              defaultValue={product.discount}
              render={({ field, fieldState }) => (
                <TextField
                  {...field}
                  fullWidth
                  label="Discount"
                  placeholder="Price discount"
                  error={!!fieldState.error}
                  helperText={fieldState.error?.message}
                  type="number"
                  inputProps={{ min: 0, max: 100 }}
                  InputProps={{ endAdornment: "%" }}
                />
              )}
            />
          </div>

          <div className="flex gap-4">
            <Controller
              name="stock_quantity"
              control={control}
              defaultValue={product.stock_quantity}
              render={({ field, fieldState }) => (
                <TextField
                  {...field}
                  fullWidth
                  label="Stock"
                  placeholder="Product count in stock"
                  error={!!fieldState.error}
                  helperText={fieldState.error?.message}
                  type="number"
                  inputProps={{ min: 0 }}
                />
              )}
            />
            <Controller
              name="unit"
              control={control}
              defaultValue={product.unit}
              render={({ field, fieldState }) => (
                <TextField
                  {...field}
                  fullWidth
                  label="Unit"
                  placeholder="Product unit. ex: KG/L/Pcs"
                  error={!!fieldState.error}
                  helperText={fieldState.error?.message}
                />
              )}
            />
          </div>

          <Controller
            name="tags"
            control={control}
            defaultValue={product.tags.toString()}
            render={({ field, fieldState }) => (
              <TextField
                {...field}
                fullWidth
                label="Tags"
                placeholder="Product Tags"
                error={!!fieldState.error}
                helperText={fieldState.error?.message}
              />
            )}
          />
        </DialogContent>

        <DialogActions>
          <Button
            variant="contained"
            onClick={() => reset()}
            disabled={loading}
          >
            Reset
          </Button>
          <Button
            type="submit"
            variant="contained"
            onClick={() => {
              handleSubmit(onSubmit);
            }}
            disabled={loading}
          >
            Update
          </Button>
        </DialogActions>
      </form>
    </Dialog>
  );
});

export default EditProductModal;
