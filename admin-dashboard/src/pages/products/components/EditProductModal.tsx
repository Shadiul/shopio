import NiceModal, { useModal } from "@ebay/nice-modal-react";
import { yupResolver } from "@hookform/resolvers/yup";
import { Close, Delete } from "@mui/icons-material";
import {
  Button,
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
  FormControl,
  FormHelperText,
  IconButton,
  InputLabel,
  MenuItem,
  Select,
  TextField,
  Typography,
} from "@mui/material";
import { collection } from "firebase/firestore";
import { useState } from "react";
import { useCollection } from "react-firebase-hooks/firestore";
import { Controller, SubmitHandler, useForm } from "react-hook-form";
import { firestore } from "../../../configs/firebase";
import { IEditProductFormInput, IProduct } from "../../../interfaces/IProduct";
import { EDIT_PRODUCT_SCHEMA } from "../../../schemas/edit_product_schema";

type EditProductsProps = { product: IProduct };

const EditProductModal = NiceModal.create<EditProductsProps>(({ product }) => {
  const modal = useModal();

  const [loading, setLoading] = useState(false);

  const [categoriesSnapshot, categoriesLoading] = useCollection(
    collection(firestore, "categories")
  );

  const editProduct = async (data: IEditProductFormInput) => {
    setLoading(true);

    const newData = { ...data, tags: data.tags.split(",") };
    await firestore.collection("products").doc(product.id).update(newData);

    setLoading(false);
  };

  const { handleSubmit, reset, control } = useForm<IEditProductFormInput>({
    resolver: yupResolver(EDIT_PRODUCT_SCHEMA),
  });

  const [images, setImages] = useState<string[]>(product.images ?? []);
  const [imageUrl, setImageUrl] = useState("");

  const onAddImageUrl = () => {
    if (imageUrl && imageUrl.length > 1) {
      var joined = images.concat(imageUrl);
      setImages(joined);
      setImageUrl("");
    }
  };
  const onDeleteImage = (index: number) => {
    setImages(images.filter((image, i) => i !== index));
  };

  const onSubmit: SubmitHandler<IEditProductFormInput> = (data) => {
    editProduct({ ...data, images: images });
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
            name="category_id"
            control={control}
            defaultValue={product.category_id ?? ""}
            render={({ field, fieldState }) => (
              <FormControl>
                <InputLabel id="category">Category</InputLabel>
                <Select
                  {...field}
                  value={categoriesLoading ? "" : field.value}
                  disabled={categoriesLoading}
                  labelId="category"
                  label="Category"
                  placeholder="Product Category"
                  error={!!fieldState.error}
                >
                  <MenuItem value="">None</MenuItem>
                  {categoriesSnapshot?.docs.map((doc, index) => {
                    const data = doc.data();
                    return (
                      <MenuItem key={index} value={data.id}>
                        {data.name}
                      </MenuItem>
                    );
                  })}
                </Select>
                {fieldState.error && (
                  <FormHelperText>{fieldState.error?.message}</FormHelperText>
                )}
              </FormControl>
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

          <div className="flex flex-col gap-4">
            <Typography>Images</Typography>
            {images.length < 1 && <Typography>No Images</Typography>}
            <div className="grid grid-cols-4 gap-4">
              {images.map((image, index) => (
                <div
                  key={index}
                  className="relative h-full w-full border-2 bg-gray-500"
                >
                  <div className="absolute z-10 top-1/4 left-1/4 flex justify-center">
                    <IconButton
                      onClick={() => onDeleteImage(index)}
                      sx={{
                        backgroundColor: "primary.light",
                        opacity: 0.5,
                        ":hover": {
                          opacity: 1,
                          backgroundColor: "primary.light",
                        },
                      }}
                    >
                      <Delete />
                    </IconButton>
                  </div>
                  <img src={image} alt={product.name} className="" />
                </div>
              ))}
            </div>
            <div className="flex gap-4">
              <TextField
                fullWidth
                placeholder="Image URL"
                value={imageUrl}
                onChange={(event) => setImageUrl(event.target.value)}
              />
              <Button variant="contained" onClick={onAddImageUrl}>
                Add
              </Button>
            </div>
          </div>
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
