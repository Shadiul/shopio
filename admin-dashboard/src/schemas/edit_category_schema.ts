import * as yup from "yup";

export const EDIT_CATEGORY_SCHEMA = yup
  .object({
    name: yup.string().required("Name is required"),
    icon: yup.string().url().required("Icon is required"),
    products_count: yup.number().required("Products count is required"),
  })
  .required();
