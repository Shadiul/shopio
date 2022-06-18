import NiceModal, { useModal } from "@ebay/nice-modal-react";
import { yupResolver } from "@hookform/resolvers/yup";
import { Add, Close, Delete } from "@mui/icons-material";
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
import { ICreateCategoryFormInput } from "../../../interfaces/ICategory";
import { ICreateProductFormInput } from "../../../interfaces/IProduct";
import { CREATE_CATEGORY_SCHEMA } from "../../../schemas/create_category_schema";
import { CREATE_PRODUCT_SCHEMA } from "../../../schemas/create_product_schema";

const CreateProductModal = NiceModal.create(() => {
  const modal = useModal();

  const [loading, setLoading] = useState(false);

  const [categoriesSnapshot] = useCollection(
    collection(firestore, "categories")
  );

  const createCategory = async (data: ICreateCategoryFormInput) => {
    setLoading(true);

    const doc = await firestore.collection("categories").add(data);
    await doc.update({ id: doc.id });

    setLoading(false);
  };

  const { handleSubmit, reset, control } = useForm<ICreateCategoryFormInput>({
    resolver: yupResolver(CREATE_CATEGORY_SCHEMA),
  });

  const onSubmit: SubmitHandler<ICreateCategoryFormInput> = (data) => {
    createCategory(data);
    reset();
    modal.remove();
  };

  return (
    <Dialog open={modal.visible} onClose={modal.remove}>
      <div className="flex justify-between items-center gap-2">
        <DialogTitle>Create New Category</DialogTitle>

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
            name="icon"
            control={control}
            defaultValue=""
            render={({ field, fieldState }) => (
              <div className="flex gap-4 items-center">
                <TextField
                  {...field}
                  fullWidth
                  label="Icon"
                  placeholder="Category Icon"
                  error={!!fieldState.error}
                  helperText={fieldState.error?.message}
                />
                {field.value && (
                  <img src={field.value} alt="icon" height={32} width={32} />
                )}
              </div>
            )}
          />

          <Controller
            name="products_count"
            control={control}
            defaultValue={0}
            render={({ field, fieldState }) => (
              <TextField
                {...field}
                fullWidth
                label="Products Count"
                placeholder="0"
                error={!!fieldState.error}
                helperText={fieldState.error?.message}
                type="number"
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
