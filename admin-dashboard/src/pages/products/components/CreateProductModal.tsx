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
import { ICreateProductFormInput } from "../../../interfaces/IProduct";
import { CREATE_PRODUCT_SCHEMA } from "../../../schemas/create_product_schema";

const CreateProductModal = NiceModal.create(() => {
  const modal = useModal();

  const [loading, setLoading] = useState(false);

  const createProduct = async (data: ICreateProductFormInput) => {
    setLoading(true);

    const newData = { ...data, tags: data.tags.split(",") };
    const doc = await firestore.collection("products").add(newData);
    await doc.update({ id: doc.id });

    setLoading(false);
  };

  const { handleSubmit, reset, control } = useForm<ICreateProductFormInput>({
    resolver: yupResolver(CREATE_PRODUCT_SCHEMA),
  });

  const onSubmit: SubmitHandler<ICreateProductFormInput> = (data) => {
    createProduct(data);
    reset();
    modal.remove();
  };

  return (
    <Dialog open={modal.visible} onClose={modal.remove}>
      <div className="flex justify-between items-center gap-2">
        <DialogTitle>Create New Product</DialogTitle>

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
            defaultValue=""
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
            defaultValue=""
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
              defaultValue={0}
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
              defaultValue={0}
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
              defaultValue={0}
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
              defaultValue=""
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
            defaultValue=""
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
            Add
          </Button>
        </DialogActions>
      </form>
    </Dialog>
  );
});

export default CreateProductModal;
