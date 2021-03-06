<template>
  <div>
    <p>
      <button v-on:click="add()" class="btn btn-white btn-default btn-round">
        <i class="ace-icon fa fa-edit"></i>
        Add
      </button>
      &nbsp;
      <button v-on:click="list(1)" class="btn btn-white btn-default btn-round">
        <i class="ace-icon fa fa-refresh red2"></i>
        Refresh
      </button>

    </p>

    <pagination ref="pagination" v-bind:list="list" v-bind:itemCount=5></pagination>

    <table id="simple-table" class="table table-bordered table-hover">
      <thead>
      <tr><#list fieldList as field>
      <#if field.getNameHump()!="createdAt" && field.getNameHump()!="updatedAt">
      <th>${field.getName()}</th>
      </#if>
      </#list>
      <th>operations</th>

      </tr>
      </thead>

      <tbody>
      <tr v-for="${domain} in ${domain}s">
        <#list fieldList as field>
        <#if field.getNameHump()!="createdAt" && field.getNameHump()!="updatedAt">
          <#if field.getEnum()>
        <td>{{${field.getEnumConst()} | optionKV(${domain}.${field.getNameHump()})}}</td>
          <#else>
        <td>{{${domain}.${field.getNameHump()}}}</td>
          </#if>
        </#if>
        </#list>
        <td>
          <div class="hidden-sm hidden-xs btn-group">
            <button v-on:click="edit(${domain})" class="btn btn-xs btn-info">
              <i class="ace-icon fa fa-pencil bigger-120"></i>
            </button>
            <button v-on:click="del(${domain}.id)" class="btn btn-xs btn-danger">
              <i class="ace-icon fa fa-trash-o bigger-120"></i>
            </button>
          </div>
        </td>
      </tr>
      </tbody>
    </table>

    <div id="form-modal" class="modal fade" tabindex="-1" role="dialog">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                aria-hidden="true">&times;</span></button>
            <h4 class="modal-title">New ${domain}</h4>
          </div>
          <div class="modal-body">
            <form class="form-horizontal">
              <#list fieldList as field>
              <#if field.getName()!="id" && field.getNameHump()!="createdAt" && field.getNameHump()!="updatedAt">
              <div class="form-group">
                <label>${field.getName()}</label>
                <#if field.getEnum()>
                <div col-sm-10>
                  <select v-model="${domain}.${field.getNameHump()}" class="form-control">
                    <option v-for="o in ${field.getEnumConst()}" v-bind:value="o.key">{{o.value}}</option>
                  </select>
                </div>
                <#else>
                <div col-sm-10>
                  <input v-model="${domain}.${field.getNameHump()}" class="form-control">
                </div>
                </#if>
              </div>
              </#if>
              </#list>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
            <button v-on:click="save()" type="button" class="btn btn-primary">Save</button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

  </div>

</template>

<script>
import Pagination from "../../components/pagination";

export default {
  components: {Pagination},
  name: "${module}-${domain}",
  data: function () {
    return {
      ${domain}: {}, //new chapter
      ${domain}s: [],
      <#list fieldList as field>
        <#if field.getEnum()>
      ${field.getEnumConst()}: ${field.getEnumConst()},
        </#if>
      </#list>
    }
  },
  mounted: function () {
    let _this = this;
    _this.$refs.pagination.size = 5;
    _this.list(1);
  },
  methods: {
    add() {
      let _this = this;
      _this.${domain} = {};
      $("#form-modal").modal("show");
    },

    edit(${domain}) {
      let _this = this;
      _this.${domain} = $.extend({}, ${domain});
      $("#form-modal").modal("show");
    },

    list(page) {
      let _this = this;
      Loading.show();
      _this.$ajax.post(process.env.VUE_APP_SERVER + '/${module}/admin/${domain}/list', {
        page: page,
        size: _this.$refs.pagination.size
      })
          .then((response) => {
            Loading.hide();
            let resp = response.data;
            _this.${domain}s = resp.content.list;
            _this.$refs.pagination.render(page, resp.content.total);
          })
    },

    save() {
      let _this = this;
      //validation
      if(1 != 1
      <#list fieldList as field>
        <#if field.getName()!="id" && field.getNameHump()!="createdAt" && field.getNameHump()!="updatedAt">
        <#if field.nullable>
        || !Validator.require(_this.${domain}.${field.getNameHump()}, "${field.getName()}")
        </#if>
        <#if (field.length>0)>
        || !Validator.length(_this.${domain}.${field.getNameHump()}, "${field.getName()}", 1, ${field.length?c})
        </#if>
        </#if>
      </#list>
      ) {
        return;
      }

      Loading.show();
      _this.$ajax.post(process.env.VUE_APP_SERVER + '/${module}/admin/${domain}/save',
          _this.${domain}
      )
          .then((response) => {
            Loading.hide();
            let resp = response.data
            if (resp.success) {
              $("#form-modal").modal("hide");
              _this.list(1);
              Toast.success("A new item has been successfully saved!")
            } else {
              Toast.warning(resp.message);
            }
          })
    },

    del(id) {
      let _this = this;
      Confirm.show("The deleted ${domain} cannot be reverted!", function () {
        Loading.show();
        _this.$ajax.delete(process.env.VUE_APP_SERVER + '/${module}/admin/${domain}/delete/' + id)
            .then((response) => {
              Loading.hide();
              let resp = response.data
              if (resp.success) {
                _this.list(1);
                Toast.success("You deleted an item!")
              }
            })
      })
    }
  }
}
</script>