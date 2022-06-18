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
import {
  ICategory,
  IEditCategoryFormInput,
} from "../../../interfaces/ICategory";
import { EDIT_CATEGORY_SCHEMA } from "../../../schemas/edit_category_schema";

type EditCategoryProps = { category: ICategory };

const EditCategoryModal = NiceModal.create<EditCategoryProps>(
  ({ category }) => {
    const modal = useModal();

    const [loading, setLoading] = useState(false);

    const editProduct = async (data: IEditCategoryFormInput) => {
      setLoading(true);

      await firestore.collection("categories").doc(category.id).update(data);

      setLoading(false);
    };

    const { handleSubmit, reset, control } = useForm<IEditCategoryFormInput>({
      resolver: yupResolver(EDIT_CATEGORY_SCHEMA),
    });

    const onSubmit: SubmitHandler<IEditCategoryFormInput> = (data) => {
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
              defaultValue={category.name}
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
              defaultValue={category.icon}
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
              defaultValue={category.products_count}
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
              Update
            </Button>
          </DialogActions>
        </form>
      </Dialog>
    );
  }
);

export default EditCategoryModal;
