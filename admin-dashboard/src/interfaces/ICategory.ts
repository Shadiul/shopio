export interface ICategory {
  id: string;
  name: string;
  icon: string;
  products_count: number;
}
export interface ICreateCategoryFormInput {
  id: string;
  name: string;
  icon: string;
  products_count: number;
}
export interface IEditCategoryFormInput extends ICreateCategoryFormInput {}
